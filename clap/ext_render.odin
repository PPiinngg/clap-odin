package clap

EXT_RENDER :: "clap.render"

Render_Mode :: enum i32{
    REALTIME = 0,
    OFFLINE  = 1,
}

Plugin_Render :: struct{
    has_hard_realtime_requirement: proc "c" (plugin: ^Plugin) -> bool,
    set: proc "c" (plugin: ^Plugin, mode: Render_Mode) -> bool,
}
