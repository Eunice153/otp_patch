# 0x10 普通单帧，≤512B
python3 sm3/sm3单帧/sm3_oneshot.py COM24

# NO3 0x41 大帧，最大 128KB
python3 sm3/sm3单帧/sm3_oneshot_41.py COM24

# 0x10 异常/边界
python3 sm3/sm3异常输入/sm3_abnormal.py COM24

# NO3 0x41 长度边界
python3 sm3/sm3异常输入/sm3_abnormal_41.py COM24