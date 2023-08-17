package clap

import "core:c"

// Audio Ports
EXT_AUDIO_PORTS   :: "clap.audio-ports"
AUDIO_PORT_MONO   :: "mono"
AUDIO_PORT_STEREO :: "stereo"

Audio_Port_Flag :: enum{
	IS_MAIN                     = 1 << 0,
	SUPPORTS_64BITS             = 1 << 1,
	PREFERS_64BITS              = 1 << 2,
	REQUIRES_COMMON_SAMPLE_SIZE = 1 << 3,
}

Audio_Port_Rescan :: enum{
	NAMES         = 1 << 0,
	FLAGS         = 1 << 1,
	CHANNEL_COUNT = 1 << 2,
	PORT_TYPE     = 1 << 3,
	IN_PLACE_PAIR = 1 << 4,
	LIST          = 1 << 5,
}

Audio_Port_Info :: struct{
	id:            Clap_Id,
	name:          [NAME_SIZE]u8,
	flags:         u32,
	channel_count: u32,
	port_type:     cstring,
	in_place_pair: u32,
}

Plugin_Audio_Ports :: struct{
	count: proc "c" (plugin: ^Plugin, is_input: bool) -> u32,
	get:   proc "c" (plugin: ^Plugin, index: u32, is_input: bool, info: ^Audio_Port_Info) -> bool,
}

Host_Audio_Ports :: struct{
	is_rescan_flag_supported: proc "c" (host: ^Host, flag: u32) -> bool,
	rescan:                   proc "c" (host: ^Host, flags: u32),
}

// Audio Ports Config
EXT_AUDIO_PORTS_CONFIG      :: "clap.audio-ports-config"
EXT_AUDIO_PORTS_CONFIG_INFO :: "clap.audio-ports-config-info/draft-0"

Audio_Ports_Config :: struct{
	id:   u32,
	name: [NAME_SIZE]u8,
	
	input_port_count:  u32,
	output_port_count: u32,

	has_main_input:           bool,
	main_input_channel_count: u32,
	main_input_port_type:     cstring,

	has_main_output:           bool,
	main_output_channel_count: u32,
	main_output_port_type:     cstring,
}

Plugin_Audio_Ports_Config :: struct{
	count:  proc "c" (plugin: ^Plugin) -> u32,
	get:    proc "c" (plugin: ^Plugin, index: u32, config: ^Audio_Ports_Config) -> bool,
	select: proc "c" (plugin: ^Plugin, config_id: Clap_Id) -> bool,
}

Plugin_Audio_Ports_Config_Info :: struct{
	current_config: proc "c" (plugin: ^Plugin) -> Clap_Id,
	get:            proc "c" (plugin: ^Plugin, config_id: Clap_Id, port_index: u32, is_input: bool, info: ^Audio_Port_Info),
}

Host_Audio_Ports_Config :: struct{
	rescan: proc "c" (host: ^Host)
}
