package clap

CORE_EVENT_SPACE_ID :: 0

Event_Flags :: enum u32{
    IS_LIVE     = 1 << 0,
    DONT_RECORD = 1 << 1,
}

Event_Type :: enum u32{
    NOTE_ON         = 0,
    NOTE_OFF        = 1,
    NOTE_CHOKE      = 2,
    NOTE_END        = 3,
    NOTE_EXPRESSION = 4,

    PARAM_VALUE         = 5,
    PARAM_MOD           = 6,
    PARAM_GESTURE_BEGIN = 7,
    PARAM_GESTURE_END   = 8,

    TRANSPORT = 9,

    MIDI       = 10,
    MIDI_SYSEX = 11,
    MIDI2      = 12,
}

Event_Header :: struct {
    size:       u32,
    time:       u32,
    space_id:   u16,
    event_type: u16,
    flags:      u32,
}

Input_Events :: struct {
    ctx:  rawptr,
    size: proc "c" (list: ^Input_Events) -> u32,
    get:  proc "c" (list: ^Input_Events, index: u32) -> ^Event_Header,
}

Output_Events :: struct {
    ctx:      rawptr,
    try_push: proc "c" (list: ^Input_Events, event: ^Event_Header) -> bool,
}

/////////////////
// Note Events //
/////////////////
Event_Note :: struct {
    header: Event_Header,

    note_id:    i32,
    port_index: i16,
    channel:    i16,
    key:        i16,
    velocity:   f64,
}

Note_Expression_Type :: enum i32{
   VOLUME     = 0,
   PAN        = 1,
   TUNING     = 2,
   VIBRATO    = 3,
   EXPRESSION = 4,
   BRIGHTNESS = 5,
   PRESSURE   = 6,
}

Event_Note_Expression :: struct {
    header:        Event_Header,
    expression_id: Note_Expression_Type,

    note_id:    i32,
    port_index: i16,
    channel:    i16,
    key:        i16,
    value:      f64,
}

//////////////////////
// Parameter Events //
//////////////////////
Event_Param_Value :: struct {
    header: Event_Header,

    param_id: Clap_Id,
    cookie:   rawptr,

    note_id:    i32,
    port_index: i16,
    channel:    i16,
    key:        i16,

    value: f64,
}

Event_Param_Mod :: struct {
    header: Event_Header,

    param_id: Clap_Id,
    cookie:   rawptr,

    note_id:    i32,
    port_index: i16,
    channel:    i16,
    key:        i16,

    amount: f64,
}

Event_Param_Gesture :: struct {
    header: Event_Header,

    param_id: Clap_Id,
}

//////////////////////
// Transport Events //
//////////////////////
Transport_Flags :: enum u32{
    HAS_TEMPO            = 1 << 0,
    HAS_BEATS_TIMELINE   = 1 << 1,
    HAS_SECONDS_TIMELINE = 1 << 2,
    HAS_TIME_SIGNATURE   = 1 << 3,
    IS_PLAYING           = 1 << 4,
    IS_RECORDING         = 1 << 5,
    IS_LOOP_ACTIVE       = 1 << 6,
    IS_WITHIN_PRE_ROLL   = 1 << 7,
};

Event_Transport :: struct {
    header: Event_Header,
    flags:  u32,

    song_pos_beats:   Beat_Time,
    song_pos_seconds: Sec_Time,

    tempo:     f64,
    tempo_inc: f64,

    loop_start_beats:   Beat_Time,
    loop_end_beats:     Beat_Time,
    loop_start_seconds: Sec_Time,
    loop_end_seconds:   Sec_Time,

    bar_start:  Beat_Time,
    bar_number: i32,

    tsig_num:   i16,
    tsig_denum: i16,
}

/////////////////
// MIDI Events //
/////////////////
Event_Midi :: struct {
    header: Event_Header,

    port_index: u16,
    data:    [3]u8,
}

Event_Midi_Sysex :: struct {
    header: Event_Header,

    port_index: u16,
    buffer:  [^]u8,
    size:       u32,
}

Event_Midi2 :: struct {
    header: Event_Header,

    port_index: u16,
    data:    [4]u8,
}
