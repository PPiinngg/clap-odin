package test_plugin

import "core:runtime"
import clap "../clap"

@export clap_entry := clap.Plugin_Entry{
    clap_version = clap.CLAP_VERSION,

	init = proc "c" (plugin_path: cstring) -> bool {
        return true
    },

	deinit = proc "c" () {},

	get_factory = proc "c" (factory_id: cstring) -> rawptr {
        if factory_id == clap.PLUGIN_FACTORY_ID {
            return &factory
        }
        return nil
    },
}

factory := clap.Plugin_Factory{
    get_plugin_count = proc "c" (factory: ^clap.Plugin_Factory) -> u32 {
        return 1
    },

	get_plugin_descriptor = proc "c" (factory: ^clap.Plugin_Factory, index: u32) -> ^clap.Plugin_Descriptor {
        return &descriptor
    },

	create_plugin = proc "c" (factory: ^clap.Plugin_Factory, host: ^clap.Host, plugin_id: cstring) -> ^clap.Plugin {
        if plugin_id != descriptor.id {
            return nil
        }

        context = runtime.default_context()
        p := new(State)
        
        p.host = host
        p.plugin.desc = &descriptor
        p.plugin.plugin_data = &p
        p.plugin.init = init
        p.plugin.destroy = destroy
        p.plugin.activate = activate
        p.plugin.deactivate = deactivate
        p.plugin.start_processing = start_processing
        p.plugin.stop_processing = stop_processing
        p.plugin.reset = reset
        p.plugin.process = process
        p.plugin.get_extension = get_extension
        p.plugin.on_main_thread = proc "c" (plugin: ^clap.Plugin) {}

        return &p.plugin
    },
}
