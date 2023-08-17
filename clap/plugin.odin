package clap

import "core:c"

Plugin_Descriptor :: struct{
	clap_version: Version,

	id:          cstring,
	name:        cstring,
	vendor:      cstring,
	url:         cstring,
	manual_url:  cstring,
	support_url: cstring,
	verison:     cstring,
	description: cstring,
	features: [^]cstring,
}

PLUGIN_FACTORY_ID :: "clap.plugin-factory"
Plugin_Factory :: struct{
	get_plugin_count:      proc "c" (factory: ^Plugin_Factory) -> u32,
	get_plugin_descriptor: proc "c" (factory: ^Plugin_Factory, index: u32) -> ^Plugin_Descriptor,
	create_plugin:         proc "c" (factory: ^Plugin_Factory, host: ^Host, plugin_id: cstring) -> ^Plugin,
}

Plugin :: struct{
	plugin_data: rawptr,

	init:             proc "c" (plugin: ^Plugin) -> bool,
	destroy:          proc "c" (plugin: ^Plugin),
	activate:         proc "c" (plugin: ^Plugin, sample_rate: f64, min_frames, max_frames: u32) -> bool,
	deactivate:       proc "c" (plugin: ^Plugin),
	start_processing: proc "c" (plugin: ^Plugin) -> bool,
	stop_processing:  proc "c" (plugin: ^Plugin),
	reset:            proc "c" (plugin: ^Plugin),
	
	process:          proc "c" (plugin: ^Plugin, process: ^Process) -> Process_Status,
	get_extension:    proc "c" (plugin: ^Plugin, id: cstring) -> rawptr,
	on_main_thread:   proc "c" (plugin: ^Plugin),
}

//////////////
// Features //
/////////////////////
// Plugin category //
/////////////////////
PLUGIN_FEATURE_INSTRUMENT    :: "instrument"
PLUGIN_FEATURE_AUDIO_EFFECT  :: "audio-effect"
PLUGIN_FEATURE_NOTE_EFFECT   :: "note-effect"
PLUGIN_FEATURE_NOTE_DETECTOR :: "note-detector"
PLUGIN_FEATURE_ANALYZER      :: "analyzer"

/////////////////////////
// Plugin sub-category //
/////////////////////////
PLUGIN_FEATURE_SYNTHESIZER       :: "synthesizer"
PLUGIN_FEATURE_SAMPLER           :: "sampler"
PLUGIN_FEATURE_DRUM              :: "drum" // For single drum
PLUGIN_FEATURE_DRUM_MACHINE      :: "drum-machine"

PLUGIN_FEATURE_FILTER            :: "filter"
PLUGIN_FEATURE_PHASER            :: "phaser"
PLUGIN_FEATURE_EQUALIZER         :: "equalizer"
PLUGIN_FEATURE_DEESSER           :: "de-esser"
PLUGIN_FEATURE_PHASE_VOCODER     :: "phase-vocoder"
PLUGIN_FEATURE_GRANULAR          :: "granular"
PLUGIN_FEATURE_FREQUENCY_SHIFTER :: "frequency-shifter"
PLUGIN_FEATURE_PITCH_SHIFTER     :: "pitch-shifter"

PLUGIN_FEATURE_DISTORTION        :: "distortion"
PLUGIN_FEATURE_TRANSIENT_SHAPER  :: "transient-shaper"
PLUGIN_FEATURE_COMPRESSOR        :: "compressor"
PLUGIN_FEATURE_EXPANDER          :: "expander"
PLUGIN_FEATURE_GATE              :: "gate"
PLUGIN_FEATURE_LIMITER           :: "limiter"

PLUGIN_FEATURE_FLANGER           :: "flanger"
PLUGIN_FEATURE_CHORUS            :: "chorus"
PLUGIN_FEATURE_DELAY             :: "delay"
PLUGIN_FEATURE_REVERB            :: "reverb"

PLUGIN_FEATURE_TREMOLO           :: "tremolo"
PLUGIN_FEATURE_GLITCH            :: "glitch"

PLUGIN_FEATURE_UTILITY           :: "utility"
PLUGIN_FEATURE_PITCH_CORRECTION  :: "pitch-correction"
PLUGIN_FEATURE_RESTORATION       :: "restoration" // repair the sound

PLUGIN_FEATURE_MULTI_EFFECTS     :: "multi-effects"

PLUGIN_FEATURE_MIXING            :: "mixing"
PLUGIN_FEATURE_MASTERING         :: "mastering"

////////////////////////
// Audio Capabilities //
////////////////////////
PLUGIN_FEATURE_MONO      :: "mono"
PLUGIN_FEATURE_STEREO    :: "stereo"
PLUGIN_FEATURE_SURROUND  :: "surround"
PLUGIN_FEATURE_AMBISONIC :: "ambisonic"
