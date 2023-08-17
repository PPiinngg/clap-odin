package clap

// Thread Check
EXT_THREAD_CHECK :: "clap.thread-check"

Host_Thread_Check :: struct{
    is_main_thread:  proc "c" (host: ^Host) -> bool,
    is_audio_thread: proc "c" (host: ^Host) -> bool,
}

// Thread Pool
EXT_THREAD_POOL :: "clap.thread-pool"

Plugin_Thread_Pool :: struct{
    exec: proc "c" (plugin: ^Plugin, task_index: u32),
}

Host_Thread_Pool :: struct{
    request_exec: proc "c" (host: ^Host, num_tasks: u32) -> bool,
}
