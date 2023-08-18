package ext

import clap "../../clap"

import "core:c"

EXT_POSIX_FD_SUPPORT :: "clap.posix-fd-support"

Posix_FD_Event_Flag :: enum u32{
    READ  = 1 << 0,
    WRITE = 1 << 1,
    ERROR = 1 << 2,
}

Plugin_Posix_FD_Support :: struct{
    on_fd: proc "c" (plugin: ^clap.Plugin, fd: c.int, flags: u32),
}

Host_Posix_FD_Support :: struct{
    register_fd:   proc "c" (host: ^clap.Host, fd: c.int, flags: u32) -> bool,
    modify_fd:     proc "c" (host: ^clap.Host, fd: c.int, flags: u32) -> bool,
    unregister_fd: proc "c" (host: ^clap.Host, fd: c.int) -> bool,
}
