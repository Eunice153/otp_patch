#ifndef CMD_UART_H
#define CMD_UART_H

#include <stdint.h>

#define CMD_SOF         0x5A
#define CMD_MAX_DATA    512

void cmd_uart_init(void);
void cmd_uart_poll(void);

/* 命令分发：返回驱动 ACK 码（0 成功，负数错误） */
int8_t cmd_dispatch(uint8_t cmd,
                    const uint8_t *in, uint16_t in_len,
                    uint8_t *out, uint16_t *out_len);

#endif
