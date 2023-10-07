package test_plugin

import "core:runtime"
import clap "../clap"

start_processing :: proc "c" (plugin: ^clap.Plugin) -> bool {
    return true
}

stop_processing :: proc "c" (plugin: ^clap.Plugin) {}

reset :: proc "c" (plugin: ^clap.Plugin) {}

process :: proc ($T: typeid, ch_c: u32, frm_c: u32, i_buf: [^][^]T, o_buf: [^][^]T) {
	for ch_i in 0..<ch_c {
		o_ch := o_buf[ch_i]
		i_ch := i_buf[ch_i]

		for frm_i in 0..<frm_c {
			o_ch[frm_i] = i_ch[frm_i]
		}
	}
}

init_process :: proc "c" (plugin: ^clap.Plugin, clap_process: ^clap.Process) -> clap.Process_Status {
	context = runtime.default_context()

    main_in := clap_process.audio_inputs[0]
    main_out := clap_process.audio_outputs[0]

	ch_c := clap_process.audio_inputs[0].channel_count
	frm_c := clap_process.frames_count
    
    if clap_process.audio_outputs[0].data32 != nil {
		process(f32, ch_c, frm_c, main_in.data32, main_out.data32)
    } else if clap_process.audio_outputs[0].data64 != nil {
		process(f64, ch_c, frm_c, main_in.data64, main_out.data64)
    }

    return clap.Process_Status.CONTINUE
}
