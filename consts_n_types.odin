package clap

NAME_SIZE :: 256
PATH_SIZE :: 1024

// Fixed Point
Beat_Time :: i64
Sec_Time  :: i64
BEAT_TIME_FACTOR :: i64(1 << 31)
SEC_TIME_FACTOR  :: i64(1 << 31)

Clap_Id :: u32
INVALID_ID :: u32(0xffffffff)
