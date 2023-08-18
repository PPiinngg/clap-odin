package ext

import clap "../../clap"

EXT_TIMER_SUPPORT :: "clap.timer-support"

Plugin_Timer_Support :: struct{
    on_timer: proc "c" (plugin: ^clap.Plugin, timer_id: clap.Clap_Id)
}

Host_Timer_Support :: struct{
    register_timer:   proc "c" (host: ^clap.Host, period_ms: u32, timer_id: ^clap.Clap_Id) -> bool,
    unregister_timer: proc "c" (host: ^clap.Host, timer_id: clap.Clap_Id) -> bool,
}
