package clap

EXT_LATENCY :: "clap.latency"

Plugin_Latency :: struct{
	get: proc "c" (plugin: ^Plugin) -> u32,
}

Host_Latency :: struct{
	changed: proc "c" (host: ^Host),
}
