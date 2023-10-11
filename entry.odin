package clap

import "core:c"

Plugin_Entry :: struct {
	clap_version: Version,
	init:        proc "c" (plugin_path: cstring) -> bool,
	deinit:      proc "c" (),
	get_factory: proc "c" (factory_id: cstring) -> rawptr,
}
