package clap

Log_Severity :: enum i32{
    DEBUG   = 0,
    INFO    = 1,
    WARNING = 2,
    ERROR   = 3,
    FATAL   = 4,
    HOST_MISBEHAVING   = 5,
    PLUGIN_MISBEHAVING = 6,
}

Host_Log :: struct{
    log: proc "c" (host: ^Host, severity: Log_Severity, msg: cstring),
}
