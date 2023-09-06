package test_plugin

import clap "../clap"

start_processing :: proc "c" (plugin: ^clap.Plugin) -> bool {
    return true
}

stop_processing :: proc "c" (plugin: ^clap.Plugin) {}

reset :: proc "c" (plugin: ^clap.Plugin) {}

process :: proc "c" (plugin: ^clap.Plugin, process: ^clap.Process) -> clap.Process_Status {
    if process.audio_outputs[0].data32 != nil {
        for channel in 0..<process.audio_inputs[0].channel_count {
            for frame in 0..<process.frames_count {
                process.audio_outputs[0].data32[channel][frame] = process.audio_inputs[0].data32[channel][frame]
            }
        }
    }

    // if process.audio_outputs[0].data64 != nil {
    //     for channel in 0..<process.audio_inputs[0].channel_count {
    //         for frame in 0..<process.frames_count {
    //             process.audio_outputs[0].data64[channel][frame] = process.audio_inputs[0].data64[channel][frame]
    //         }
    //     }
    // }

    return clap.Process_Status.CONTINUE
}
