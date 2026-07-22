module vlogger

struct DefaultMessage {
	message_fieldname string
	message_chan      chan DefaultMessage
	fields            []Field
	// discard marks a message whose level is below the logger's level. It is set
	// once, when the message is created, so that every subsequent builder call
	// and the send itself become no-ops instead of allocating and queueing a
	// record that the writer would only throw away.
	discard bool
pub:
	level MessageLevel
}

fn (m DefaultMessage) append_field(field Field) DefaultMessage {
	if m.discard {
		return m
	}

	mut new_fields := m.fields.clone()
	new_fields << field

	return DefaultMessage{
		message_fieldname: m.message_fieldname
		message_chan:      m.message_chan
		level:             m.level
		fields:            new_fields
	}
}

// fields returns the fields accumulated on the message so far.
pub fn (m DefaultMessage) fields() []Field {
	return m.fields
}

// bool appends a boolean field and returns the updated message.
pub fn (m DefaultMessage) bool(key string, value bool) DefaultMessage {
	return m.append_field(Field{
		key:   key
		value: value
	})
}

// string appends a string field and returns the updated message.
pub fn (m DefaultMessage) string(key string, value string) DefaultMessage {
	return m.append_field(Field{
		key:   key
		value: value
	})
}

// i8 appends a signed 8-bit integer field and returns the updated message.
pub fn (m DefaultMessage) i8(key string, value i8) DefaultMessage {
	return m.append_field(Field{
		key:   key
		value: value
	})
}

// i16 appends a signed 16-bit integer field and returns the updated message.
pub fn (m DefaultMessage) i16(key string, value i16) DefaultMessage {
	return m.append_field(Field{
		key:   key
		value: value
	})
}

// i32 appends a signed 32-bit integer field and returns the updated message.
pub fn (m DefaultMessage) i32(key string, value i32) DefaultMessage {
	return m.append_field(Field{
		key:   key
		value: value
	})
}

// i64 appends a signed 64-bit integer field and returns the updated message.
pub fn (m DefaultMessage) i64(key string, value i64) DefaultMessage {
	return m.append_field(Field{
		key:   key
		value: value
	})
}

// u8 appends an unsigned 8-bit integer field and returns the updated message.
pub fn (m DefaultMessage) u8(key string, value u8) DefaultMessage {
	return m.append_field(Field{
		key:   key
		value: value
	})
}

// u16 appends an unsigned 16-bit integer field and returns the updated message.
pub fn (m DefaultMessage) u16(key string, value u16) DefaultMessage {
	return m.append_field(Field{
		key:   key
		value: value
	})
}

// u32 appends an unsigned 32-bit integer field and returns the updated message.
pub fn (m DefaultMessage) u32(key string, value u32) DefaultMessage {
	return m.append_field(Field{
		key:   key
		value: value
	})
}

// u64 appends an unsigned 64-bit integer field and returns the updated message.
pub fn (m DefaultMessage) u64(key string, value u64) DefaultMessage {
	return m.append_field(Field{
		key:   key
		value: value
	})
}

// rune appends a rune field and returns the updated message.
pub fn (m DefaultMessage) rune(key string, value rune) DefaultMessage {
	return m.append_field(Field{
		key:   key
		value: value
	})
}

// f32 appends a 32-bit floating point field and returns the updated message.
pub fn (m DefaultMessage) f32(key string, value f32) DefaultMessage {
	return m.append_field(Field{
		key:   key
		value: value
	})
}

// f64 appends a 64-bit floating point field and returns the updated message.
pub fn (m DefaultMessage) f64(key string, value f64) DefaultMessage {
	return m.append_field(Field{
		key:   key
		value: value
	})
}

// array appends an array field and returns the updated message.
pub fn (m DefaultMessage) array(key string, value []Value) DefaultMessage {
	return m.append_field(Field{
		key:   key
		value: value
	})
}

// map appends a map field and returns the updated message.
pub fn (m DefaultMessage) map(key string, value map[string]Value) DefaultMessage {
	return m.append_field(Field{
		key:   key
		value: value
	})
}

// strut appends a nested Loggable field and returns the updated message.
pub fn (m DefaultMessage) strut(key string, value Loggable) DefaultMessage {
	return m.append_field(Field{
		key:   key
		value: Nested{value}
	})
}

// err appends an error field and returns the updated message.
pub fn (m DefaultMessage) err(key string, value IError) DefaultMessage {
	return m.append_field(Field{
		key:   key
		value: Err{value}
	})
}

// custom appends a field holding a type that renders itself as a scalar, and
// returns the updated message.
pub fn (m DefaultMessage) custom(key string, value Renderable) DefaultMessage {
	return m.append_field(Field{
		key:   key
		value: Custom{value}
	})
}

// send pushes the message onto the logger's channel, blocking until there is
// room in the buffer. Use `try_send` for a non-blocking variant. Messages whose
// level is below the logger's level are dropped here without touching the
// channel.
pub fn (m DefaultMessage) send() DefaultMessage {
	if m.discard {
		return m
	}

	m.message_chan <- m

	return m
}

// try_send pushes the message onto the logger's channel without blocking.
// If the push does not succeed, error_handler is called with the reason.
pub fn (m DefaultMessage) try_send(error_handler ErrorHandlerFn) DefaultMessage {
	if m.discard {
		return m
	}

	result := m.message_chan.try_push(m)
	if result != .success {
		error_handler(error('failed writing to channel: ${result}'))
	}

	return m
}

// message appends msg under the configured message fieldname and sends the
// record. It is shorthand for `.string(message_fieldname, msg).send()`.
//
// This is a terminal operation and returns nothing on purpose: the record has
// already been dispatched, so there is nothing left to add to it.
pub fn (m DefaultMessage) message(msg string) {
	if m.discard {
		return
	}

	m.string(m.message_fieldname, msg).send()
}
