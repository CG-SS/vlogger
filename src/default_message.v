module vlogger

struct DefaultMessage {
	message_fieldname string
	message_chan      chan DefaultMessage
	fields            []Field
pub:
	level MessageLevel
}

fn (m DefaultMessage) append_field(field Field) DefaultMessage {
	mut new_fields := m.fields.clone()
	new_fields << field

	return DefaultMessage{
		message_fieldname: m.message_fieldname
		message_chan:      m.message_chan
		level:             m.level
		fields:            new_fields
	}
}

pub fn (m DefaultMessage) fields() []Field {
	return m.fields
}

pub fn (m DefaultMessage) bool(key string, value bool) DefaultMessage {
	return m.append_field(Field{
		key:   key
		value: BoolValue{value}
	})
}

pub fn (m DefaultMessage) string(key string, value string) DefaultMessage {
	return m.append_field(Field{
		key:   key
		value: StringValue{value}
	})
}

pub fn (m DefaultMessage) i8(key string, value i8) DefaultMessage {
	return m.append_field(Field{
		key:   key
		value: I8Value{value}
	})
}

pub fn (m DefaultMessage) i16(key string, value i16) DefaultMessage {
	return m.append_field(Field{
		key:   key
		value: I16Value{value}
	})
}

pub fn (m DefaultMessage) i32(key string, value i32) DefaultMessage {
	return m.append_field(Field{
		key:   key
		value: I32Value{value}
	})
}

pub fn (m DefaultMessage) i64(key string, value i64) DefaultMessage {
	return m.append_field(Field{
		key:   key
		value: I64Value{value}
	})
}

pub fn (m DefaultMessage) u8(key string, value u8) DefaultMessage {
	return m.append_field(Field{
		key:   key
		value: U8Value{value}
	})
}

pub fn (m DefaultMessage) u16(key string, value u16) DefaultMessage {
	return m.append_field(Field{
		key:   key
		value: U16Value{value}
	})
}

pub fn (m DefaultMessage) u32(key string, value u32) DefaultMessage {
	return m.append_field(Field{
		key:   key
		value: U32Value{value}
	})
}

pub fn (m DefaultMessage) u64(key string, value u64) DefaultMessage {
	return m.append_field(Field{
		key:   key
		value: U64Value{value}
	})
}

pub fn (m DefaultMessage) rune(key string, value rune) DefaultMessage {
	return m.append_field(Field{
		key:   key
		value: RuneValue{value}
	})
}

pub fn (m DefaultMessage) f32(key string, value f32) DefaultMessage {
	return m.append_field(Field{
		key:   key
		value: F32Value{value}
	})
}

pub fn (m DefaultMessage) f64(key string, value f64) DefaultMessage {
	return m.append_field(Field{
		key:   key
		value: F64Value{value}
	})
}

pub fn (m DefaultMessage) array(key string, value []Value) DefaultMessage {
	return m.append_field(Field{
		key:   key
		value: ArrayValue{value}
	})
}

pub fn (m DefaultMessage) map(key string, value map[string]Value) DefaultMessage {
	return m.append_field(Field{
		key:   key
		value: MapValue{value}
	})
}

pub fn (m DefaultMessage) strut(key string, value Loggable) DefaultMessage {
	return m.append_field(Field{
		key:   key
		value: StrutValue{value}
	})
}

pub fn (m DefaultMessage) err(key string, value IError) DefaultMessage {
	return m.append_field(Field{
		key:   key
		value: ErrorValue{value}
	})
}

pub fn (m DefaultMessage) send() DefaultMessage {
	m.message_chan <- m

	return m
}

pub fn (m DefaultMessage) try_send(error_handler ErrorHandlerFn) DefaultMessage {
	result := m.message_chan.try_push(m)
	if result != .success {
		error_handler(error('failed writing to channel: ${result}'))
	}

	return m
}

pub fn (m DefaultMessage) message(msg string) DefaultMessage {
	m.string(m.message_fieldname, msg).send()

	return m
}
