#include <string.h>
#include <stdlib.h>
#include "ls_soc_gpio.h"
#include "platform.h"
#include "log.h"
#include <stdio.h>
#include <string.h>
#include <stdint.h>
#include <stdbool.h>
#include "log.h"
#include "ls_hal_otp_ctrl.h"
#include "ls_msp_otp_ctrl.h"

uint8_t read_buffer[4096]={0};
void otp_test_read()
{
	HAL_OTP_Read(0, read_buffer, sizeof(read_buffer));
	LOG_I("OTP read -addr:0x%x -length:0x%x", 0, sizeof(read_buffer));
	//     LOG_HEX(read_buffer, sizeof(read_buffer));
	for (int i = 0; i < sizeof(read_buffer); i++) {
	if (i % 16 == 0 && i != 0) {
		LOG_RAW("\r\n");  // 每16字节换行
	}
	if (i % 256 == 0&& i != 0) {
		LOG_RAW("\r\n");
	}
	LOG_RAW("%02X ", read_buffer[i]);
	}
	LOG_RAW("\n");
}

#include "incbin.h"
INCBIN(MyOtpData, "../tools/otp_patch_4K_direct.bin");
static void otp_test_write_bin()
{
	// 将write_text 替换为 gMyOtspDataData
	// gMyOtpDataData 是指向嵌入 bin 数据的指针
	if (HAL_OTP_Write(0, (uint8_t *)gMyOtpDataData, gMyOtpDataSize) != HAL_OK)
	{
		LOG_I("OTP write_data fail...");
	}
	LOG_I("OTP write -addr:0x%x -length:0x%x", 0, gMyOtpDataSize);

	// 打印刚才写入的内容
	LOG_HEX((uint8_t *)gMyOtpDataData, gMyOtpDataSize);
}
int main(void)
{
	// 基础系统初始化
	sys_init_none();
	LOG_I("OTP Test start.");
	HAL_OTP_CTRL_Init();
	otp_test_read();
	otp_test_write_bin();
	// otp_test_write();
	otp_test_read();
	LOG_I("OTP Test Complete.");
	return 0;
}


