package test_plugin

import "../clap"

//////////
// Meta //
//////////
AUDIO_INPUTS  :: 1
AUDIO_OUTPUTS :: 1

descriptor :: clap.Plugin_Descriptor{
	clap_version = clap.CLAP_VERSION,
	id          = "dev.clap-odin.test",
	name        = "Test Plugin",
	vendor      = "clap-odin",
	url         = "https://github.com/PPiinngg/clap-odin",
	manual_url  = "https://github.com/PPiinngg/clap-odin/blob/main/README.md",
	support_url = "https://github.com/PPiinngg/clap-odin/issues",
	verison     = "0.0.1",
	description = "Barebones CLAP plugin to test the Odin implementation of the standard",
	features    = raw_data([]cstring{
		clap.PLUGIN_FEATURE_AUDIO_EFFECT,
		clap.PLUGIN_FEATURE_STEREO,
		clap.PLUGIN_FEATURE_UTILITY,
		nil,
	}),
}

////////////
// Events //
////////////

// INIT / UNINIT
init :: proc "c" (plugin: ^Plugin) -> bool {
	clap_state.host_log = clap_state.host.get_extension(clap_state.host, )

}
destroy :: proc "c" (plugin: ^Plugin) {}

// BYPASS / UNBYPASS
activate :: proc "c" (plugin: ^Plugin, sample_rate: f64, min_frames, max_frames: u32) -> bool { return true }
deactivate :: proc "c" (plugin: ^Plugin) { reset(plugin) }

// PROCESS
start_processing :: proc "c" (plugin: ^Plugin) -> bool { return true }
stop_processing :: proc "c" (plugin: ^Plugin) {}

reset :: proc "c" (plugin: ^Plugin) {}

process_status :: proc "c" (plugin: ^Plugin, process: ^Process) -> Process_Status {

}

get_extension :: proc "c" (plugin: ^Plugin, id: cstring) -> rawptr {

}

on_main_thread :: proc "c" (plugin: ^Plugin) {}
