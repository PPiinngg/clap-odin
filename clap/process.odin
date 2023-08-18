package clap

Process_Status :: enum i32{
    ERROR                 = 0,
    CONTINUE              = 1,
    CONTINUE_IF_NOT_QUIET = 2,
    TAIL                  = 3,
    SLEEP                 = 4,
}

Process :: struct{
    steady_time:  i64,
    frames_count: u32,
    transport:    ^Event_Transport,

    audio_inputs:        [^]Audio_Buffer,
    audio_outputs:       [^]Audio_Buffer,
    audio_inputs_count:  u32,
    audio_outputs_count: u32,

    in_events:  ^Input_Events,
    out_events: ^Output_Events,
}
