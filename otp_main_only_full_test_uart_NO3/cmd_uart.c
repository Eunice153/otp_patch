#include "cmd_uart.h"
#include "cmd_dispatch.h"
#include "ls_hal_uart.h"
#include "ls_msp_uart.h"
#include "ls_soc_gpio.h"
#include "ls_soc_pinmux.h"
#include "field_manipulate.h"
#include <stdbool.h>
#include <stddef.h>

#define CMD_UART_PORT       UART1
#define CMD_UART_TX_PIN     PN04
#define CMD_UART_RX_PIN     PN03

static UART_HandleTypeDef s_huart;

enum {
    ST_SOF = 0, ST_CMD, ST_LEN_H, ST_LEN_L, ST_DATA,
    /* 0x40/0x41 大数据：4B 长度 + 大缓冲 */
    ST_BULK_LEN0, ST_BULK_LEN1, ST_BULK_LEN2, ST_BULK_LEN3, ST_BULK_DATA
};

/* 半帧无新字节时的轮询次数上限（软件超时兜底）。
 * 1 次轮询约为几个 CPU 周期，200000 次约几 ms ~ 几十 ms，
 * 远大于 115200 下字节间隔（约 87 us），不会误伤正常帧。 */
#define CMD_FRAME_GAP_CNT   200000u
/* 大帧连续传输时，USB 转串口会有较长间隔；大数据帧用更宽的
 * 软件超时，硬件 RTO 在大数据状态下不复位状态机。 */
#define CMD_BULK_GAP_CNT    50000000u

static uint8_t  s_state;
static uint8_t  s_cmd;
static uint16_t s_need;
static uint16_t s_len;
static uint32_t s_idle_cnt;
static uint8_t  s_buf[CMD_MAX_DATA];
static uint8_t  s_out[CMD_MAX_DATA];

/* 0x40/0x41 大数据缓冲：128KB 输入 + 128KB 输出。
 * 0x40 头部最多 3+1+32+16B，0x41 无头。 */
static uint8_t  s_bulk_in[CMD_BULK_MAX_EXTRA + CMD_BULK_MAX_DATA];
static uint8_t  s_bulk_out[CMD_BULK_MAX_DATA];
static uint32_t s_bulk_need;
static uint32_t s_bulk_len;

static inline int bulk_state(void)
{
    return s_state >= ST_BULK_LEN0;
}

static inline int uart_rx_ready(void)
{
    return REG_FIELD_RD(CMD_UART_PORT->SR, UART_SR_RFNE) != 0;
}

static inline uint8_t uart_rx_byte(void)
{
    return (uint8_t)(CMD_UART_PORT->RBR & 0xFF);
}

static inline void uart_tx_byte(uint8_t b)
{
    while (!REG_FIELD_RD(CMD_UART_PORT->SR, UART_SR_TFNF)) { }
    CMD_UART_PORT->TBR = b;
}

static void uart_tx_buf(const uint8_t *p, uint32_t n)
{
    while (n--) {
        uart_tx_byte(*p++);
    }
}

void cmd_uart_init(void)
{
    /* 日志和命令共用 UART1：等日志发送完再重新配置，
     * 否则 HAL_UART_Init 复位 FIFO 会把最后一行日志截断。
     * 加超时上限，避免 BUSY 异常时死等。 */
    for (volatile uint32_t i = 0;
         i < 1000000 && REG_FIELD_RD(CMD_UART_PORT->SR, UART_SR_BUSY);
         i++) { }

    pinmux_uart1_init(CMD_UART_TX_PIN, CMD_UART_RX_PIN);
    io_pull_write(CMD_UART_RX_PIN, IO_PULL_UP);

    s_huart.UARTX           = CMD_UART_PORT;
    s_huart.RTOValue        = 0x05;
    s_huart.Init.BaudRate   = UART_BAUDRATE_115200;
    s_huart.Init.MSBEN      = 0;
    s_huart.Init.Parity     = UART_NOPARITY;
    s_huart.Init.StopBits   = UART_STOPBITS1;
    s_huart.Init.WordLength = UART_BYTESIZE8;
    /* 用户模式不能访问 CLIC，用不带中断的初始化 */
    HAL_UART_Init_NoIRQ(&s_huart);
        // LOG_I("UART1 BRR=0x%08X", UART1->BRR);
    /* 硬件接收超时，用于半帧复位 */
    CMD_UART_PORT->RTOR = 0x05;
    REG_FIELD_WR(CMD_UART_PORT->LCR, UART_LCR_RTOEN, 1);

    s_state = ST_SOF;
    s_len   = 0;
    s_bulk_need = 0;
    s_bulk_len  = 0;
}

static void send_frame(uint8_t cmd, int8_t status,
                       const uint8_t *data, uint16_t len)
{
    uart_tx_byte(CMD_SOF);
    uart_tx_byte(cmd);
    uart_tx_byte((uint8_t)status);      /* 负数按补码发送：-3 -> 0xFD */
    uart_tx_byte((uint8_t)(len >> 8));
    uart_tx_byte((uint8_t)(len & 0xFF));
    if (len != 0 && data != NULL) {
        uart_tx_buf(data, len);
    }
}

static void send_bulk_frame(uint8_t cmd, int8_t status,
                            const uint8_t *data, uint32_t len)
{
    uart_tx_byte(CMD_SOF);
    uart_tx_byte(cmd);
    uart_tx_byte((uint8_t)status);
    uart_tx_byte((uint8_t)(len >> 24));
    uart_tx_byte((uint8_t)(len >> 16));
    uart_tx_byte((uint8_t)(len >> 8));
    uart_tx_byte((uint8_t)len);
    if (len != 0 && data != NULL) {
        uart_tx_buf(data, len);
    }
}

static void handle_frame(void)
{
    uint16_t out_len = 0;
    int8_t status = cmd_dispatch(s_cmd, s_buf, s_len, s_out, &out_len);
    send_frame(s_cmd, status, s_out, out_len);
}

static void handle_bulk_frame(void)
{
    uint32_t out_len = 0;
    int8_t status;

    if (s_cmd == CMD_SM4_BULK) {
        status = cmd_bulk_dispatch(s_bulk_in, s_bulk_need,
                                   s_bulk_out, &out_len);
    } else {
        status = cmd_sm3_bulk_dispatch(s_bulk_in, s_bulk_need,
                                       s_bulk_out, &out_len);
    }
    send_bulk_frame(s_cmd, status, s_bulk_out, out_len);
}

void cmd_uart_poll(void)
{
    /* 接收超时：普通半帧丢弃；大数据帧正在接收时不能因为字节
     * 间隔丢掉状态，交给下面的软件兜底计数。 */
    if (REG_FIELD_RD(CMD_UART_PORT->RIF, UART_RTO)) {
        CMD_UART_PORT->ICR = UART_IT_RTO;
        if (s_state != ST_SOF && !bulk_state()) {
            s_state = ST_SOF;
            s_len   = 0;
        }
    }

    /* 硬件 RTO 在 RX FIFO 被读空后可能不再置位，这里加软件兜底：
     * 半帧长时间没有新字节就丢弃，避免吞掉下一帧的帧头 */
    if (!uart_rx_ready()) {
        if (s_state != ST_SOF) {
            uint32_t limit = bulk_state() ? CMD_BULK_GAP_CNT : CMD_FRAME_GAP_CNT;
            if (++s_idle_cnt > limit) {
                s_state     = ST_SOF;
                s_len       = 0;
                s_bulk_need = 0;
                s_bulk_len  = 0;
                s_idle_cnt  = 0;
            }
        } else {
            s_idle_cnt = 0;
        }
        return;
    }

    s_idle_cnt = 0;

    while (uart_rx_ready()) {
        uint8_t b = uart_rx_byte();

        switch (s_state) {
        case ST_SOF:
            if (b == CMD_SOF) {
                s_state = ST_CMD;
            }
            break;

        case ST_CMD:
            s_cmd = b;
            if (b == CMD_SM4_BULK || b == CMD_SM3_BULK) {
                s_bulk_need = 0;
                s_state = ST_BULK_LEN0;
            } else {
                s_state = ST_LEN_H;
            }
            break;

        case ST_LEN_H:
            s_need = (uint16_t)b << 8;
            s_state = ST_LEN_L;
            break;

        case ST_LEN_L:
            s_need |= b;
            s_len = 0;
            if (s_need > CMD_MAX_DATA) {
                s_state = ST_SOF;
            } else if (s_need == 0) {
                handle_frame();
                s_state = ST_SOF;
            } else {
                s_state = ST_DATA;
            }
            break;

        case ST_DATA:
            s_buf[s_len++] = b;
            if (s_len >= s_need) {
                handle_frame();
                s_state = ST_SOF;
            }
            break;

        case ST_BULK_LEN0:
            s_bulk_need = (uint32_t)b << 24;
            s_state = ST_BULK_LEN1;
            break;

        case ST_BULK_LEN1:
            s_bulk_need |= (uint32_t)b << 16;
            s_state = ST_BULK_LEN2;
            break;

        case ST_BULK_LEN2:
            s_bulk_need |= (uint32_t)b << 8;
            s_state = ST_BULK_LEN3;
            break;

        case ST_BULK_LEN3:
            s_bulk_need |= (uint32_t)b;
            s_bulk_len = 0;
            if (s_bulk_need > sizeof(s_bulk_in)) {
                s_state = ST_SOF;
            } else if (s_bulk_need == 0) {
                handle_bulk_frame();
                s_state = ST_SOF;
            } else {
                s_state = ST_BULK_DATA;
            }
            break;

        case ST_BULK_DATA:
            s_bulk_in[s_bulk_len++] = b;
            if (s_bulk_len >= s_bulk_need) {
                handle_bulk_frame();
                s_state = ST_SOF;
            }
            break;

        default:
            s_state = ST_SOF;
            break;
        }
    }
}
