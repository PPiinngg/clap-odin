package clap

EXT_EVENT_REGISTRY :: "clap.event-registry"

Host_Event_Registry :: struct{
	query: proc "c" (host: ^Host, space_name: cstring, space_id: ^u16) -> bool,
}
