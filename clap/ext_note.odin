package clap

// Note Name
EXT_NOTE_NAME :: "clap.note-name"

Note_Name :: struct{
    name:    [NAME_SIZE]u8,
    port:    i16,
    key:     i16,
    channel: i16,
}

Plugin_Note_Name :: struct{
    count: proc "c" (plugin: ^Plugin) -> u32,
    get:   proc "c" (plugin: ^Plugin, index: u32, note_name: ^Note_Name) -> bool,
}

Host_Note_Name :: struct{
    changed: proc "c" (host: ^Host)
}

// Note Ports
EXT_NOTE_PORTS :: "clap.note-ports"

Note_Dialect :: enum{
    CLAP_NOTE_DIALECT_CLAP     = 1 << 0,
    CLAP_NOTE_DIALECT_MIDI     = 1 << 1,
    CLAP_NOTE_DIALECT_MIDI_MPE = 1 << 2,
    CLAP_NOTE_DIALECT_MIDI2    = 1 << 3,
}

Note_Port_Info :: struct{
    id: Clap_Id,
    supported_dialects: u32,
    preferred_dialects: u32,
    name: [NAME_SIZE]u8,
}

Plugin_Note_Ports :: struct{
    count: proc "c" (plugin: ^Plugin, is_input: bool) -> u32,
    get:   proc "c" (plugin: ^Plugin, index: u32, is_input: bool, info: ^Note_Port_Info) -> bool,
}

Note_Port_Rescan_Flag :: enum{
    ALL   = 1 << 0,
    NAMES = 1 << 1,
}

Host_Note_Ports :: struct{
    supported_dialects: proc "c" (host: ^Host) -> u32,
    rescan:             proc "c" (host: ^Host, flags: u32),
}
