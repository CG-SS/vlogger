module vlogger

import time

struct TestMessage {
	fields []Field
}

fn (t TestMessage) append_field(field Field) Message {
	mut new_fields := t.fields.clone()
	new_fields << field

	return TestMessage{
		fields: new_fields
	}
}

fn (_ TestMessage) level() MessageLevel {
	return .none
}

fn (t TestMessage) fields() []Field {
	return t.fields
}

fn (t TestMessage) bool(key string, value bool) Message {
	return t.append_field(Field{
		key:   key
		value: BoolValue{value}
	})
}

fn (t TestMessage) string(key string, value string) Message {
	return t.append_field(Field{
		key:   key
		value: StringValue{value}
	})
}

fn (t TestMessage) i8(key string, value i8) Message {
	return t.append_field(Field{
		key:   key
		value: I8Value{value}
	})
}

fn (t TestMessage) i16(key string, value i16) Message {
	return t.append_field(Field{
		key:   key
		value: I16Value{value}
	})
}

fn (t TestMessage) i32(key string, value i32) Message {
	return t.append_field(Field{
		key:   key
		value: I32Value{value}
	})
}

fn (t TestMessage) i64(key string, value i64) Message {
	return t.append_field(Field{
		key:   key
		value: I64Value{value}
	})
}

fn (t TestMessage) u8(key string, value u8) Message {
	return t.append_field(Field{
		key:   key
		value: U8Value{value}
	})
}

fn (t TestMessage) u16(key string, value u16) Message {
	return t.append_field(Field{
		key:   key
		value: U16Value{value}
	})
}

fn (t TestMessage) u32(key string, value u32) Message {
	return t.append_field(Field{
		key:   key
		value: U32Value{value}
	})
}

fn (t TestMessage) u64(key string, value u64) Message {
	return t.append_field(Field{
		key:   key
		value: U64Value{value}
	})
}

fn (t TestMessage) rune(key string, value rune) Message {
	return t.append_field(Field{
		key:   key
		value: RuneValue{value}
	})
}

fn (t TestMessage) f32(key string, value f32) Message {
	return t.append_field(Field{
		key:   key
		value: F32Value{value}
	})
}

fn (t TestMessage) f64(key string, value f64) Message {
	return t.append_field(Field{
		key:   key
		value: F64Value{value}
	})
}

fn (t TestMessage) array(key string, value []Value) Message {
	return t.append_field(Field{
		key:   key
		value: ArrayValue{value}
	})
}

fn (t TestMessage) map(key string, value map[string]Value) Message {
	return t.append_field(Field{
		key:   key
		value: MapValue{value}
	})
}

fn (t TestMessage) strut(key string, value Loggable) Message {
	return t.append_field(Field{
		key:   key
		value: StrutValue{value}
	})
}

fn (t TestMessage) err(key string, value IError) Message {
	return t.append_field(Field{
		key:   key
		value: ErrorValue{value}
	})
}

fn (t TestMessage) send() Message {
	return t
}

fn (t TestMessage) try_send(_ ErrorHandlerFn) Message {
	return t
}

fn (t TestMessage) message(msg string) Message {
	t.string(default_message_fieldname, msg).send()

	return t
}

struct AppendTimestampTestCase {
	append_fn     HookFn @[required]
	expect_format string
}

fn test_append_timestamp_fn_normal_formats() {
	// TODO: update test cases when time.parse_format supports units smaller than ss
	test_cases := [
		AppendTimestampTestCase{
			append_fn:     append_timestamp_fn(TimestampFormat.default, 'timestamp')
			expect_format: 'YYYY-MM-DD HH:mm'
		},
		AppendTimestampTestCase{
			append_fn:     append_timestamp_fn(TimestampFormat.ss, 'timestamp')
			expect_format: 'YYYY-MM-DD HH:mm:ss'
		},
	]

	for test in test_cases {
		out := test.append_fn(TestMessage{})

		fields := out.fields()

		assert fields.len == 1
		assert fields[0].key == 'timestamp'

		field_value := fields[0].value
		match field_value {
			StringValue {
				time.parse_format(field_value.value, test.expect_format) or {
					assert false, 'parse_format failed: ${err}'
				}
			}
			else {
				assert false, 'should be a StringValue'
			}
		}
	}
}

struct AppendTimestampSingleFormatTestCase {
	append_fn HookFn @[required]
}

fn test_append_timestamp_fn_rfc3339_format() {
	test_cases := [
		AppendTimestampSingleFormatTestCase{
			append_fn: append_timestamp_fn(TimestampFormat.rfc3339, 'timestamp')
		},
		AppendTimestampSingleFormatTestCase{
			append_fn: append_timestamp_fn(TimestampFormat.rfc3339_micro, 'timestamp')
		},
		AppendTimestampSingleFormatTestCase{
			append_fn: append_timestamp_fn(TimestampFormat.rfc3339_nano, 'timestamp')
		},
	]

	for test in test_cases {
		out := test.append_fn(TestMessage{})

		fields := out.fields()

		assert fields.len == 1
		assert fields[0].key == 'timestamp'

		field_value := fields[0].value
		match field_value {
			StringValue {
				time.parse_rfc3339(field_value.value) or {
					assert false, 'parse_rfc3339 failed: ${err}'
				}
			}
			else {
				assert false, 'should be a StringValue'
			}
		}
	}
}

fn test_append_timestamp_fn_unix_format() {
	test_cases := [
		AppendTimestampSingleFormatTestCase{
			append_fn: append_timestamp_fn(TimestampFormat.unix, 'timestamp')
		},
		AppendTimestampSingleFormatTestCase{
			append_fn: append_timestamp_fn(TimestampFormat.unix_nano, 'timestamp')
		},
		AppendTimestampSingleFormatTestCase{
			append_fn: append_timestamp_fn(TimestampFormat.unix_milli, 'timestamp')
		},
		AppendTimestampSingleFormatTestCase{
			append_fn: append_timestamp_fn(TimestampFormat.unix_micro, 'timestamp')
		},
	]

	for test in test_cases {
		out := test.append_fn(TestMessage{})

		fields := out.fields()

		assert fields.len == 1
		assert fields[0].key == 'timestamp'

		field_value := fields[0].value
		match field_value {
			I64Value {}
			else {
				assert false, 'should be a I64Value'
			}
		}
	}
}
