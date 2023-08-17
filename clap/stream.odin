package clap

IStream :: struct{
    ctx:  rawptr,
    read: proc "c" (stream: ^IStream, buffer: rawptr, size: u64) -> i64,
}

OStream :: struct{
    ctx:   rawptr,
    write: proc "c" (stream: ^OStream, buffer: rawptr, size: u64) -> i64,
}
