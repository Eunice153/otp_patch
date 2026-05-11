import struct
import os
import sys

def bit_reverse(value, width):
    r = 0
    for _ in range(width):
        r = (r << 1) | (value & 1)
        value >>= 1
    return r

def crc32_hw_compatible(data: bytes) -> int:
    poly = 0x04C11DB7
    crc = 0xFFFFFFFF
    for b in data:
        b = bit_reverse(b, 8)
        crc ^= (b << 24)
        for _ in range(8):
            if crc & 0x80000000:
                crc = ((crc << 1) ^ poly) & 0xFFFFFFFF
            else:
                crc = (crc << 1) & 0xFFFFFFFF
    crc = bit_reverse(crc, 32)
    crc ^= 0xFFFFFFFF
    return crc

def process_otp_patch(input_otp_path):
    # 配置参数
    output_bin_path = 'otp_patch_4K_direct.bin'
    output_txt_path = 'otp_patch_array.txt'
    offset = 0x280#0x480
    total_size = 4 * 1024  # 4K = 4096 Bytes

    if not os.path.exists(input_otp_path):
        print(f"错误: 找不到文件 {input_otp_path}")
        return

    # 1. 读取并处理补丁数据
    with open(input_otp_path, 'rb') as f:
        otp_patch_data = f.read()

    patch_len = len(otp_patch_data)
    patch_crc = crc32_hw_compatible(otp_patch_data)

    # 2. 初始化 4K 数据缓冲区
    output_data = bytearray([0xFF] * total_size)

    # 3. 填充头部数据 (0x00 - 0x1C)
    header_values = [
        0x796ff141, 0x07f69209, 0x8085aa99, 0xa9803a77,
        0x928086de, 0xfeb05800, 0xffffffff, 0xffffffff,
    ]
    for i, val in enumerate(header_values):
        output_data[i * 4 : i * 4 + 4] = struct.pack('<I', val)

    # 4. 填充 0x5C - 0x8C 的配置数据
    filling_data = [
        0x50155015, 0xe0c7caf3, 0xe0c7ca73, 0xffffffff,
        0xffffffff, 0x01040202, 0x00000006, 0xa0199210,
        0xa1099300, 0x00011300, 0xffff028b, 0xFFFFDFDF,#ffffffdf只把flash_dis配置1,0xFFFFDFDF是把自测打开，flash_dis为0;0xFFFFFF9F把log关闭
        0xffffffff,
    ]
    for i, val in enumerate(filling_data):
        output_data[0x5C + i * 4 : 0x5C + i * 4 + 4] = struct.pack('<I', val)

    # 5. 自动填写：偏移索引、长度(0x8E)、CRC(0xD8)
    output_data[0x8d] = offset // 0x20
    output_data[0x8e:0x90] = struct.pack('<H', patch_len) # 自动提取长度
    output_data[0xd8:0xd8 + 4] = struct.pack('<I', patch_crc) # 自动计算CRC

    # 6. 嵌入补丁数据
    output_data[offset : offset + patch_len] = otp_patch_data

    # 7. 写入二进制文件
    with open(output_bin_path, 'wb') as f:
        f.write(output_data)

    # 8. 生成 C 数组文本 (调整为每行 16 个字节)
    with open(output_txt_path, 'w') as f:
        f.write(f"// OTP Patch Data Array\n")
        f.write(f"// Size: {patch_len}, CRC: 0x{patch_crc:08X}\n")
        f.write("unsigned char otp_patch_4k[] = {\n")

        # 使用 16 字节对齐
        for i in range(0, total_size, 16):
            chunk = output_data[i : i + 16]
            line = ", ".join([f"0x{b:02X}" for b in chunk])
            # 如果不是最后一行，添加逗号，保持末尾清洁
            f.write(f"    {line},\n")

        f.write("};\n")

    print(f"成功处理补丁: 长度={patch_len} (0x{patch_len:X}), CRC=0x{patch_crc:08X}")
    print(f"生成的 4K 烧录文件已保存为: {output_bin_path}")
    print(f"生成的数组数据已保存为: {output_txt_path}")

if __name__ == "__main__":
    target = sys.argv[1] if len(sys.argv) > 1 else 'otp_patch.bin'
    process_otp_patch(target)
