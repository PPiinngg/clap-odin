package ext

import clap "../../clap-odin"

EXT_PARAMS :: "clap.params"

Param_Info_Flag :: enum u32{
    STEPPED                 = 1 << 0,
    PERIODIC                = 1 << 1,
    HIDDEN                  = 1 << 2,
    READONLY                = 1 << 3,
    BYPASS                  = 1 << 4,
    AUTOMATABLE             = 1 << 5,
    AUTOMATABLE_PER_NOTE_ID = 1 << 6,
    AUTOMATABLE_PER_KEY     = 1 << 7,
    AUTOMATABLE_PER_CHANNEL = 1 << 8,
    AUTOMATABLE_PER_PORT    = 1 << 9,
    MODULATABLE             = 1 << 10,
    MODULATABLE_PER_NOTE_ID = 1 << 11,
    MODULATABLE_PER_KEY     = 1 << 12,
    MODULATABLE_PER_CHANNEL = 1 << 13,
    MODULATABLE_PER_PORT    = 1 << 14,
    REQUIRES_PROCESS        = 1 << 15,
}

Param_Rescan_Flag :: enum u32{
    VALUES = 1 << 0,
    TEXT   = 1 << 1,
    INFO   = 1 << 2,
    ALL    = 1 << 3,
}

Param_Clear_Flag :: enum u32{
   ALL         = 1 << 0,
   AUTOMATIONS = 1 << 1,
   MODULATIONS = 1 << 2,
}

Param_Info :: struct {
    id:     clap.Clap_Id,
    flags:  Param_Info_Flag,
    cookie: rawptr,

    name:   [clap.NAME_SIZE]u8,
    module: [clap.PATH_SIZE]u8,

    min_value:     f64,
    max_value:     f64,
    default_value: f64,
}

Plugin_Params :: struct {
    count:         proc "c" (plugin: ^clap.Plugin) -> u32,
    get_info:      proc "c" (plugin: ^clap.Plugin, param_index: u32, param_info: ^Param_Info) -> bool,
    get_value:     proc "c" (plugin: ^clap.Plugin, param_id: clap.Clap_Id, out_value: ^f64) -> bool,
    value_to_text: proc "c" (plugin: ^clap.Plugin, param_id: clap.Clap_Id, value: f64, out_buffer: [^]u8, out_buffer_capacity: u32) -> bool,
    text_to_value: proc "c" (plugin: ^clap.Plugin, param_id: clap.Clap_Id, param_value_text: cstring, out_value: ^f64) -> bool,
    flush:         proc "c" (plugin: ^clap.Plugin, in_events: ^clap.Input_Events, out_events: ^clap.Output_Events),
}

Host_Params :: struct {
    rescan:        proc "c" (host: ^clap.Host, flags: u32),
    clear:         proc "c" (host: ^clap.Host, param_id: clap.Clap_Id, flags: u32),
    request_flush: proc "c" (host: ^clap.Host),
}
