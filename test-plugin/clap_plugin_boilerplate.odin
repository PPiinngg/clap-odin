package test_plugin

import "../clap"

///////////
// State //
///////////
clap_state := struct{
	plugin:            clap.Plugin,
	host:              clap.Host,
	host_latency:      clap.Host_Latency,
	host_log:          clap.Host_Log,
	host_thread_check: clap.Host_Thread_Check,
	host_state:        clap.Host_State,
	latency:           u32
}

/////////////
// Factory //
/////////////
factory :: clap.Plugin_Factory{
	get_plugin_count = proc "c" (factory: ^clap.Plugin_Factory) -> u32 {
		return 1
	},

	get_plugin_descriptor = proc "c" (factory: ^clap.Plugin_Factory, index: u32) -> ^clap.Plugin_Descriptor {
		return &descriptor
	},

	create_plugin = proc "c" (factory: ^clap.Plugin_Factory, host: ^clap.Host, plugin_id: cstring) -> ^clap.Plugin {
		if (!clap.clap_version_is_compatible(host.clap_version)) {
			return nil
		}

		if (plugin_id == descriptor.id) {
			clap_state.host = host,
			clap_state.plugin.descriptor       = &descriptor,
			clap_state.plugin.plugin_data      = &clap_state,
			clap_state.plugin.init             = init,
			clap_state.plugin.destroy          = destroy,
			clap_state.plugin.activate         = activate,
			clap_state.plugin.deactivate       = deactivate,
			clap_state.plugin.start_processing = start_processing,
			clap_state.plugin.stop_processing  = stop_processing,
			clap_state.plugin.reset            = reset,
			clap_state.plugin.process          = process,
			clap_state.plugin.get_extension    = get_extension,
			clap_state.plugin.on_main_thread   = on_main_thread,
		}

		return nil
	},
}

@(export)
clap_entry :: clap.Plugin_Entry{
	clap_version = clap.CLAP_VERSION,
	init = proc "c" (plugin_path: cstring) -> bool {
		return true
	},

	deinit = proc "c" () {},

	get_factory = proc "c" (factory_id: cstring) -> rawptr {
		if (factory_id != PLUGIN_FACTORY_ID) {
			return &factory
		}
		return nil
	},
}
