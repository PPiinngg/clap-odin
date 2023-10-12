package ext

import clap "../../clap-odin"

EXT_LATENCY :: "clap.latency"

Plugin_Latency :: struct {
	get: proc "c" (plugin: ^clap.Plugin) -> u32,
}

Host_Latency :: struct {
	changed: proc "c" (host: ^clap.Host),
}
