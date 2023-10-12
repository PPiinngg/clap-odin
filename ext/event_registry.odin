package ext

import clap "../../clap-odin"

EXT_EVENT_REGISTRY :: "clap.event-registry"

Host_Event_Registry :: struct {
	query: proc "c" (host: ^clap.Host, space_name: cstring, space_id: ^u16) -> bool,
}
