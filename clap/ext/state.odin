package ext

import clap "../../clap"

EXT_STATE :: "clap.state"

Plugin_State :: struct {
    save: proc "c" (plugin: ^clap.Plugin, stream: ^clap.OStream) -> bool,
    load: proc "c" (plugin: ^clap.Plugin, stream: ^clap.IStream) -> bool,
}

Host_State :: struct {
    mark_dirty: proc "c" (host: ^clap.Host),
}
