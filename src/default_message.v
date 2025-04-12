module vlogger

struct DefaultMessage {
	message_fieldname string
	message_chan      chan Message
	fields            []Field
	message_level     MessageLevel
}

fn (m DefaultMessage) append_field(field Field) Message {
	mut new_fields := m.fields.clone()
	new_fields << field

	return DefaultMessage{
		message_fieldname: m.message_fieldname
		message_chan:      m.message_chan
		message_level:     m.message_level
		fields:            new_fields
	}
}

fn (m DefaultMessage) level() MessageLevel {
	return m.message_level
}

fn (m DefaultMessage) fields() []Field {
	return m.fields
}

fn (m DefaultMessage) bool(key string, value bool) Message {
	return m.append_field(Field{
		key:   key
		value: BoolValue{value}
	})
}

fn (m DefaultMessage) string(key string, value string) Message {
	return m.append_field(Field{
		key:   key
		value: StringValue{value}
	})
}

fn (m DefaultMessage) i8(key string, value i8) Message {
	return m.append_field(Field{
		key:   key
		value: I8Value{value}
	})
}

fn (m DefaultMessage) i16(key string, value i16) Message {
	return m.append_field(Field{
		key:   key
		value: I16Value{value}
	})
}

fn (m DefaultMessage) i32(key string, value i32) Message {
	return m.append_field(Field{
		key:   key
		value: I32Value{value}
	})
}

fn (m DefaultMessage) i64(key string, value i64) Message {
	return m.append_field(Field{
		key:   key
		value: I64Value{value}
	})
}

fn (m DefaultMessage) u8(key string, value u8) Message {
	return m.append_field(Field{
		key:   key
		value: U8Value{value}
	})
}

fn (m DefaultMessage) u16(key string, value u16) Message {
	return m.append_field(Field{
		key:   key
		value: U16Value{value}
	})
}

fn (m DefaultMessage) u32(key string, value u32) Message {
	return m.append_field(Field{
		key:   key
		value: U32Value{value}
	})
}

fn (m DefaultMessage) u64(key string, value u64) Message {
	return m.append_field(Field{
		key:   key
		value: U64Value{value}
	})
}

fn (m DefaultMessage) rune(key string, value rune) Message {
	return m.append_field(Field{
		key:   key
		value: RuneValue{value}
	})
}

fn (m DefaultMessage) f32(key string, value f32) Message {
	return m.append_field(Field{
		key:   key
		value: F32Value{value}
	})
}

fn (m DefaultMessage) f64(key string, value f64) Message {
	return m.append_field(Field{
		key:   key
		value: F64Value{value}
	})
}

fn (m DefaultMessage) array(key string, value []Value) Message {
	return m.append_field(Field{
		key:   key
		value: ArrayValue{value}
	})
}

fn (m DefaultMessage) map(key string, value map[string]Value) Message {
	return m.append_field(Field{
		key:   key
		value: MapValue{value}
	})
}

fn (m DefaultMessage) strut(key string, value Loggable) Message {
	return m.append_field(Field{
		key:   key
		value: StrutValue{value}
	})
}

fn (m DefaultMessage) err(key string, value IError) Message {
	return m.append_field(Field{
		key:   key
		value: ErrorValue{value}
	})
}

fn (m DefaultMessage) send() Message {
	m.message_chan <- Message(m)

	return m
}

fn (m DefaultMessage) try_send(error_handler ErrorHandlerFn) Message {
	result := m.message_chan.try_push(Message(m))
	if result != .success {
		error_handler(error('failed writing to channel: ${result}'))
	}

	return m
}

fn (m DefaultMessage) message(msg string) Message {
	m.string(m.message_fieldname, msg).send()

	return m
}
