module vlogger

interface Message {
	level Level
	fields []Field
	bool(key string, value bool) Message
	string(key string, value string) Message
	u8(key string, value u8) Message
	i8(key string, value i8) Message
	u16(key string, value u16) Message
	i16(key string, value i16) Message
	int(key string, value int) Message
	u32(key string, value u32) Message
	i64(key string, value i64) Message
	u64(key string, value u64) Message
	rune(key string, value rune) Message
	f32(key string, value f32) Message
	f64(key string, value f64) Message
	isize(key string, value isize) Message
	usize(key string, value usize) Message
	struct_field(key string, value StructField) Message
	array(key string, value []Field) Message
	string_map(key string, value map[string]Field) Message
	send()
}

struct LogMessage {
	message_channel chan Message [required]
	level           Level
	fields          []Field
}

pub fn (l LogMessage) bool(key string, value bool) Message {
	mut new_fields := l.fields.clone()
	new_fields << BoolField{
		value: value
		key: key
	}

	return LogMessage{
		message_channel: l.message_channel
		level: l.level
		fields: new_fields
	}
}

pub fn (l LogMessage) string(key string, value string) Message {
	return LogMessage{
		message_channel: l.message_channel
		level: l.level
		fields: l.fields
	}
}

pub fn (l LogMessage) u8(key string, value u8) Message {
	return LogMessage{
		message_channel: l.message_channel
		level: l.level
		fields: l.fields
	}
}

pub fn (l LogMessage) i8(key string, value i8) Message {
	return LogMessage{
		message_channel: l.message_channel
		level: l.level
		fields: l.fields
	}
}

pub fn (l LogMessage) u16(key string, value u16) Message {
	return LogMessage{
		message_channel: l.message_channel
		level: l.level
		fields: l.fields
	}
}

pub fn (l LogMessage) i16(key string, value i16) Message {
	return LogMessage{
		message_channel: l.message_channel
		level: l.level
		fields: l.fields
	}
}

fn (l LogMessage) int(key string, value int) Message {
	return LogMessage{
		message_channel: l.message_channel
		level: l.level
		fields: l.fields
	}
}

fn (l LogMessage) u32(key string, value u32) Message {
	return LogMessage{
		message_channel: l.message_channel
		level: l.level
		fields: l.fields
	}
}

fn (l LogMessage) i64(key string, value i64) Message {
	return LogMessage{
		message_channel: l.message_channel
		level: l.level
		fields: l.fields
	}
}

fn (l LogMessage) u64(key string, value u64) Message {
	return LogMessage{
		message_channel: l.message_channel
		level: l.level
		fields: l.fields
	}
}

fn (l LogMessage) rune(key string, value rune) Message {
	return LogMessage{
		message_channel: l.message_channel
		level: l.level
		fields: l.fields
	}
}

fn (l LogMessage) f32(key string, value f32) Message {
	return LogMessage{
		message_channel: l.message_channel
		level: l.level
		fields: l.fields
	}
}

fn (l LogMessage) f64(key string, value f64) Message {
	return LogMessage{
		message_channel: l.message_channel
		level: l.level
		fields: l.fields
	}
}

fn (l LogMessage) isize(key string, value isize) Message {
	return LogMessage{
		message_channel: l.message_channel
		level: l.level
		fields: l.fields
	}
}

fn (l LogMessage) usize(key string, value usize) Message {
	return LogMessage{
		message_channel: l.message_channel
		level: l.level
		fields: l.fields
	}
}

fn (l LogMessage) struct_field(key string, value StructField) Message {
	return LogMessage{
		message_channel: l.message_channel
		level: l.level
		fields: l.fields
	}
}

fn (l LogMessage) array(key string, value []Field) Message {
	return LogMessage{
		message_channel: l.message_channel
		level: l.level
		fields: l.fields
	}
}

fn (l LogMessage) string_map(key string, value map[string]Field) Message {
	return LogMessage{
		message_channel: l.message_channel
		level: l.level
		fields: l.fields
	}
}

pub fn (l LogMessage) send() {
	l.message_channel.try_push(l)
}
