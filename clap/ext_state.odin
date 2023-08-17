package clap

EXT_STATE :: "clap.state"

Plugin_State :: struct{
    save: proc "c" (plugin: ^Plugin, stream: ^OStream) -> bool,
    load: proc "c" (plugin: ^Plugin, stream: ^IStream) -> bool,
}

Host_State :: struct{
    mark_dirty: proc "c" (host: ^Host),
}
