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

fn (m NopMessage) bool(_ string, _ bool) NopMessage {
	return m
}

fn (m NopMessage) string(_ string, _ string) NopMessage {
	return m
}

fn (m NopMessage) i8(_ string, _ i8) NopMessage {
	return m
}

fn (m NopMessage) i16(_ string, _ i16) NopMessage {
	return m
}

fn (m NopMessage) i32(_ string, _ i32) NopMessage {
	return m
}

fn (m NopMessage) i64(_ string, _ i64) NopMessage {
	return m
}

fn (m NopMessage) u8(_ string, _ u8) NopMessage {
	return m
}

fn (m NopMessage) u16(_ string, _ u16) NopMessage {
	return m
}

fn (m NopMessage) u32(_ string, _ u32) NopMessage {
	return m
}

fn (m NopMessage) u64(_ string, _ u64) NopMessage {
	return m
}

fn (m NopMessage) rune(_ string, _ rune) NopMessage {
	return m
}

fn (m NopMessage) f32(_ string, _ f32) NopMessage {
	return m
}

fn (m NopMessage) f64(_ string, _ f64) NopMessage {
	return m
}

fn (m NopMessage) array(_ string, _ []Value) NopMessage {
	return m
}

fn (m NopMessage) map(_ string, _ map[string]Value) NopMessage {
	return m
}

fn (m NopMessage) strut(_ string, _ Loggable) NopMessage {
	return m
}

fn (m NopMessage) err(_ string, _ IError) NopMessage {
	return m
}

fn (m NopMessage) send() NopMessage {
	return m
}

fn (m NopMessage) try_send(_ ErrorHandlerFn) NopMessage {
	return m
}

fn (m NopMessage) message(_ string) NopMessage {
	return m
}
