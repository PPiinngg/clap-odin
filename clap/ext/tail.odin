package ext

import clap "../../clap"

EXT_TAIL :: "clap.tail"

Plugin_Tail :: struct{
    get: proc "c" (plugin: ^clap.Plugin) -> u32,
}

Host_Tail :: struct{
    changed: proc "c" (host: ^clap.Host),
}
