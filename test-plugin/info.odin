package test_plugin

import clap "../clap"

AUDIO_INPUTS  :: 1
AUDIO_OUTPUTS :: 1

descriptor := clap.Plugin_Descriptor{
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
