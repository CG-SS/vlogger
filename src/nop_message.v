module vlogger

struct NopMessage {
	message_level MessageLevel = MessageLevel.none
}

fn (m NopMessage) level() MessageLevel {
	return m.message_level
}

fn (_ NopMessage) fields() []Field {
	return []
}

fn (m NopMessage) bool(_ string, _ bool) Message {
	return m
}

fn (m NopMessage) string(_ string, _ string) Message {
	return m
}

fn (m NopMessage) i8(_ string, _ i8) Message {
	return m
}

fn (m NopMessage) i16(_ string, _ i16) Message {
	return m
}

fn (m NopMessage) i32(_ string, _ i32) Message {
	return m
}

fn (m NopMessage) i64(_ string, _ i64) Message {
	return m
}

fn (m NopMessage) u8(_ string, _ u8) Message {
	return m
}

fn (m NopMessage) u16(_ string, _ u16) Message {
	return m
}

fn (m NopMessage) u32(_ string, _ u32) Message {
	return m
}

fn (m NopMessage) u64(_ string, _ u64) Message {
	return m
}

fn (m NopMessage) rune(_ string, _ rune) Message {
	return m
}

fn (m NopMessage) f32(_ string, _ f32) Message {
	return m
}

fn (m NopMessage) f64(_ string, _ f64) Message {
	return m
}

fn (m NopMessage) array(_ string, _ []Value) Message {
	return m
}

fn (m NopMessage) map(_ string, _ map[string]Value) Message {
	return m
}

fn (m NopMessage) strut(_ string, _ Loggable) Message {
	return m
}

fn (m NopMessage) err(_ string, _ IError) Message {
	return m
}

fn (m NopMessage) send() Message {
	return m
}

fn (m NopMessage) try_send(_ ErrorHandlerFn) Message {
	return m
}

fn (m NopMessage) message(_ string) Message {
	return m
}
