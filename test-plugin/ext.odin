package test_plugin

import libc "core:c/libc"
import clap "../clap"
import ext "../clap/ext"

get_extension :: proc "c" (plugin: ^clap.Plugin, id: cstring) -> rawptr {
    switch id {
        case ext.EXT_LATENCY:
            return &latency
        case ext.EXT_AUDIO_PORTS:
            return &audio_ports
    }

    return nil
}

audio_ports := ext.Plugin_Audio_Ports{
    count = proc "c" (plugin: ^clap.Plugin, is_input: bool) -> u32 {
        switch is_input {
            case true:
                return AUDIO_INPUTS
            case false:
                return AUDIO_OUTPUTS
        }
        return 0
    },

    get = proc "c" (plugin: ^clap.Plugin, index: u32, is_input: bool, info: ^ext.Audio_Port_Info) -> bool {
        if (index > 0) {
            return false
        }
        info.id = 0
        portname := "Main"
        for chr, i in transmute([]u8)portname {
            info.name[i] = chr
        }

        info.channel_count = 2
        info.flags = u32(ext.Audio_Port_Flag.IS_MAIN)
        info.port_type = ext.AUDIO_PORT_STEREO
        info.in_place_pair = clap.INVALID_ID
        return true
    }
}

latency := ext.Plugin_Latency{
    get = proc "c" (plugin: ^clap.Plugin) -> u32 {
        state := cast(^State)plugin.plugin_data
        return state.latency
    }
}
