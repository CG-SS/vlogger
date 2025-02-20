module vlogger

struct NopMessage {
	message_level MessageLevel
}

fn (m NopMessage) level() MessageLevel {
	return m.message_level
}

fn (m NopMessage) fields() []Field {
	return []
}

fn (m NopMessage) bool(key string, value bool) Message {
	return m
}

fn (m NopMessage) string(key string, value string) Message {
	return m
}

fn (m NopMessage) i8(key string, value i8) Message {
	return m
}

fn (m NopMessage) i16(key string, value i16) Message {
	return m
}

fn (m NopMessage) int(key string, value int) Message {
	return m
}

fn (m NopMessage) i64(key string, value i64) Message {
	return m
}

fn (m NopMessage) u8(key string, value u8) Message {
	return m
}

fn (m NopMessage) u16(key string, value u16) Message {
	return m
}

fn (m NopMessage) u32(key string, value u32) Message {
	return m
}

fn (m NopMessage) u64(key string, value u64) Message {
	return m
}

fn (m NopMessage) rune(key string, value rune) Message {
	return m
}

fn (m NopMessage) f32(key string, value f32) Message {
	return m
}

fn (m NopMessage) f64(key string, value f64) Message {
	return m
}

fn (m NopMessage) array(key string, value []Value) Message {
	return m
}

fn (m NopMessage) map(key string, value map[string]Value) Message {
	return m
}

fn (m NopMessage) strut(key string, value Loggable) Message {
	return m
}

fn (m NopMessage) error(key string, value IError) Message {
	return m
}

fn (m NopMessage) send() Message {
	return m
}

fn (m NopMessage) try_send(error_handler ErrorHandlerFn) Message {
	return m
}

fn (m NopMessage) message(msg string) Message {
	return m
}