import argparse
import os
import struct
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


def process_otp_patch(patch_path, first200_path, code_offset):
    # 输出文件
    output_bin_path = 'otp_patch_with_bin_v2.bin'
    output_arr_path = 'otp_patch_with_bin_v2.h'

    # 固定参数
    first200_len = 0x200
    min_total = 0x400
    otp_total = 0x1000

    if not os.path.exists(patch_path):
        print(f"错误: 找不到代码 bin: {patch_path}")
        return
    if not os.path.exists(first200_path):
        print(f"错误: 找不到前 0x200 bin: {first200_path}")
        return

    with open(first200_path, 'rb') as f:
        first200 = f.read()
    if len(first200) != first200_len:
        print(f"错误: {first200_path} 大小是 {len(first200)}，期望 {first200_len} (0x200)")
        return

    with open(patch_path, 'rb') as f:
        patch_data = f.read()
    patch_len = len(patch_data)
    patch_crc = crc32_hw_compatible(patch_data)

    # 校验代码偏移
    if code_offset % 0x20 != 0:
        print(f"错误: 代码偏移 0x{code_offset:X} 不是 0x20 的倍数")
        return
    if code_offset < first200_len:
        print(f"错误: 代码偏移 0x{code_offset:X} 不能小于 0x200")
        return
    if code_offset + patch_len > otp_total:
        print(f"错误: offset + 代码长度 = 0x{code_offset + patch_len:X}，超出 4K OTP")
        return

    # 1. 先填充 0x00~0x3FF 为 0xFF；代码超出 0x400 时自动扩展
    total_len = max(min_total, code_offset + patch_len)
    output_data = bytearray(b'\xFF' * total_len)

    # 2. 前 0x200 用传入的 bin 覆盖
    output_data[0:first200_len] = first200

    # 3. 代码 bin 放到指定偏移
    output_data[code_offset:code_offset + patch_len] = patch_data

    # 4. 用代码 bin 的长度和 CRC 覆盖头字段
    idx = code_offset // 0x20
    output_data[0x8C] = 0xFF
    output_data[0x8D] = idx
    output_data[0x8E:0x90] = struct.pack('<H', patch_len)
    output_data[0xD8:0xDC] = struct.pack('<I', patch_crc)

    # 5. 写 bin，不补齐到 4K
    with open(output_bin_path, 'wb') as f:
        f.write(output_data)

    # 6. 生成数组头文件，长度与 output_data 一致
    with open(output_arr_path, 'w') as f:
        f.write("// Generated from otp_patch_with_bin_v2.bin\n")
        f.write(f"// Size: {len(output_data)} (0x{len(output_data):X}) bytes, "
                f"code offset: 0x{code_offset:X}, code length: {patch_len} "
                f"(0x{patch_len:X}), code CRC: 0x{patch_crc:08X}\n")
        f.write("uint8_t otp_patch_with_bin_v2[] = {\n")
        for i in range(0, len(output_data), 4):
            chunk = output_data[i:i + 4]
            line = ", ".join([f"0x{b:02X}" for b in chunk])
            f.write(f"\t{line}, //0X{i:X}\n")
        f.write("};\n")
        f.write("const unsigned int otp_patch_with_bin_v2_size = "
                "sizeof(otp_patch_with_bin_v2);\n")

    print(f"代码: {patch_path}, 长度={patch_len} (0x{patch_len:X}), CRC=0x{patch_crc:08X}")
    print(f"代码偏移=0x{code_offset:X} (idx=0x{idx:02X})")
    print(f"头字段: 0x8C=0xFF, 0x8D=0x{idx:02X}, 0x8E~0x8F={patch_len & 0xFFFF:04X}, "
          f"0xD8~0xDB={patch_crc:08X}")
    print(f"输出长度={len(output_data)} (0x{len(output_data):X})，未补齐到 4K")
    print(f"生成的 bin 已保存为: {output_bin_path}")
    print(f"生成的数组已保存为: {output_arr_path}")


def main():
    here = os.path.dirname(os.path.abspath(__file__))
    ap = argparse.ArgumentParser(description="把前 0x200 和代码 bin 合并成 OTP 数据")
    ap.add_argument("--bin", dest="patch_path",
                    default=os.path.join(here, '../../../../otp_patch_driver/otp_patch.bin'),
                    help="代码 bin 路径")
    ap.add_argument("--first200",
                    default=os.path.join(here, 'otp_patch_first_0x200.bin'),
                    help="前 0x200 字节 bin 路径")
    ap.add_argument("--offset", type=lambda s: int(s, 0), default=0x300,
                    help="代码在输出中的偏移，必须是 0x20 的倍数，默认 0x300")
    args = ap.parse_args()
    process_otp_patch(args.patch_path, args.first200, args.offset)


if __name__ == '__main__':
    main()
