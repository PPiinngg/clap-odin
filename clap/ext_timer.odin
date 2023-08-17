package clap

EXT_TIMER_SUPPORT :: "clap.timer-support"

Plugin_Timer_Support :: struct{
    on_timer: proc "c" (plugin: ^Plugin, timer_id: Clap_Id)
}

Host_Timer_Support :: struct{
    register_timer:   proc "c" (host: ^Host, period_ms: u32, timer_id: ^Clap_Id) -> bool,
    unregister_timer: proc "c" (host: ^Host, timer_id: Clap_Id) -> bool,
}
