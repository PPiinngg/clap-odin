package ext

import "core:c"
import clap "../../clap-odin"

EXT_GUI :: "clap.gui"

WINDOW_API_WIN32 :: "win32"
WINDOW_API_COCOA :: "cocoa"
WINDOW_API_X11 :: "x11"
WINDOW_API_WAYLAND :: "wayland"

when ODIN_OS == .Windows {
	WINDOW_API :: WINDOW_API_WIN32
} else when ODIN_OS == .Darwin {
	WINDOW_API :: WINDOW_API_COCOA
} else when ODIN_OS == .Linux {
	WINDOW_API :: WINDOW_API_X11
}

hwnd   :: rawptr  // Win32
nsview :: rawptr  // Cocoa
xwnd   :: c.ulong // X11

Window :: struct {
	api: cstring,
	handle: union{
		rawptr, // hwnd, nsview, other
		xwnd,   // X11
	},
}

Gui_Resize_Hints :: struct {
	can_resize_horizontally: bool,
	can_resize_vertically:   bool,
	preserve_aspect_ratio:   bool,
	aspect_ratio_width:      u32,
	aspect_ratio_height:     u32,
}

Plugin_Gui :: struct {
	is_api_supported:  proc "c" (plugin: ^clap.Plugin, api: cstring, is_floating: bool) -> bool,
	get_preferred_api: proc "c" (plugin: ^clap.Plugin, api: ^cstring, is_floating: bool) -> bool,

	create:            proc "c" (plugin: ^clap.Plugin, api: cstring, is_floating: bool) -> bool,
	destroy:           proc "c" (plugin: ^clap.Plugin),

	set_scale:         proc "c" (plugin: ^clap.Plugin, scale: f64) -> bool,
	get_size:          proc "c" (plugin: ^clap.Plugin, width, height: ^u32) -> bool,
	can_resize:        proc "c" (plugin: ^clap.Plugin) -> bool,
	get_resize_hints:  proc "c" (plugin: ^clap.Plugin, hints: ^Gui_Resize_Hints) -> bool,
	adjust_size:       proc "c" (plugin: ^clap.Plugin, width, height: ^u32) -> bool,
	set_size:          proc "c" (plugin: ^clap.Plugin, width, height: u32) -> bool,

	set_parent:        proc "c" (plugin: ^clap.Plugin, window: ^Window) -> bool,
	set_transient:     proc "c" (plugin: ^clap.Plugin, window: ^Window) -> bool,
	suggest_title:     proc "c" (plugin: ^clap.Plugin, title: cstring),

	show:              proc "c" (plugin: ^clap.Plugin) -> bool,
	hide:              proc "c" (plugin: ^clap.Plugin) -> bool,
}

Host_Gui :: struct {
	resize_hints_changed: proc "c" (host: ^clap.Host),
	request_resize:       proc "c" (host: ^clap.Host) -> bool,
	request_show:         proc "c" (host: ^clap.Host) -> bool,
	request_hide:         proc "c" (host: ^clap.Host) -> bool,
	closed:               proc "c" (host: ^clap.Host, was_destroyed: bool),
}
