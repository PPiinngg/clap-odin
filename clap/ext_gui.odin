package clap

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
