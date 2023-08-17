package clap

import "core:c"

Host :: struct{
	clap_version: Version,

	host_data: rawptr,

	name:    cstring,
	vendor:  cstring,
	url:     cstring,
	version: cstring,

	get_extension:    proc "c" (host: ^Host, extension_id: cstring) -> rawptr,
	request_restart:  proc "c" (host: ^Host),
	request_process:  proc "c" (host: ^Host),
	request_callback: proc "c" (host: ^Host),
}
