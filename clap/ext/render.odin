package ext

import clap "../../clap"

EXT_RENDER :: "clap.render"

Render_Mode :: enum i32{
    REALTIME = 0,
    OFFLINE  = 1,
}

Plugin_Render :: struct{
    has_hard_realtime_requirement: proc "c" (plugin: ^clap.Plugin) -> bool,
    set: proc "c" (plugin: ^clap.Plugin, mode: Render_Mode) -> bool,
}
