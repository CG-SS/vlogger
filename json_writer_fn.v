module vlogger

import io
import strings

pub type ErrorHandlerFn = fn (IError)

// write_json_message_fn returns a MessageWriterFn that encodes each message as
// a single line of JSON and writes it to writer. Any write error is passed to
// error_handler_fn.
pub fn write_json_message_fn(error_handler_fn ErrorHandlerFn, mut writer io.Writer) MessageWriterFn {
	return fn [mut writer, error_handler_fn] (msg Loggable) {
		msg_json_str := loggable_to_json_str(msg)

		writer.write('${msg_json_str}\n'.bytes()) or { error_handler_fn(err) }
	}
}

// json_escape_string returns s with every character that JSON forbids inside a
// string literal replaced by its escape sequence. Without this, any user
// supplied value containing a quote, a backslash or a control character would
// produce a record that no JSON parser accepts, and an embedded newline would
// split one record across two physical lines.
fn json_escape_string(s string) string {
	// the overwhelmingly common case is a value that needs no escaping at all,
	// so scan first and only build a new string when there is work to do
	mut needs_escaping := false
	for c in s {
		if c < 32 || c == 34 || c == 92 { // control, " or \
			needs_escaping = true
			break
		}
	}
	if !needs_escaping {
		return s
	}

	mut sb := strings.new_builder(s.len + 16)
	for c in s {
		match c {
			34 {
				sb.write_string('\\"')
			} // "
			92 {
				sb.write_string('\\\\')
			} // \
			8 {
				sb.write_string('\\b')
			}
			9 {
				sb.write_string('\\t')
			}
			10 {
				sb.write_string('\\n')
			}
			12 {
				sb.write_string('\\f')
			}
			13 {
				sb.write_string('\\r')
			}
			else {
				if c < 32 {
					sb.write_string('\\u${c:04x}')
				} else {
					sb.write_byte(c)
				}
			}
		}
	}

	return sb.str()
}

// json_quote_string returns s escaped and wrapped in double quotes.
fn json_quote_string(s string) string {
	escaped := json_escape_string(s)

	mut sb := strings.new_builder(escaped.len + 2)
	sb.write_byte(34) // "
	sb.write_string(escaped)
	sb.write_byte(34) // "

	return sb.str()
}

fn loggable_to_json_str(loggable Loggable) string {
	// fields with a blank key serialise to nothing, so drop them before joining,
	// otherwise the join leaves a stray separator behind and the record is invalid
	fields_str := loggable.fields().map(field_to_json_str).filter(it.len > 0)

	mut sb := strings.new_builder(2)
	sb.write_string('{')
	sb.write_string(fields_str.join(','))
	sb.write_string('}')

	return sb.str()
}

fn field_to_json_str(field Field) string {
	field_key := field.key
	if field_key.is_blank() {
		return ''
	}

	mut sb := strings.new_builder(3)
	sb.write_string(json_quote_string(field_key))
	sb.write_string(':')
	sb.write_string(value_to_json_str(field.value))

	return sb.str()
}

// value_to_json_str renders a Value as JSON.
//
// The match is over the sum type itself, so each branch already holds the
// payload at its real type. There is no separate tag to consult and no way to
// read a value as something it is not. Adding a variant to Value makes this
// match fail to compile until the new case is handled.
fn value_to_json_str(val Value) string {
	match val {
		bool {
			return if val { 'true' } else { 'false' }
		}
		string {
			return json_quote_string(val)
		}
		i8, i16, i32, i64 {
			return val.str()
		}
		u8, u16, u32, u64 {
			return val.str()
		}
		f32, f64 {
			return val.str()
		}
		rune {
			// JSON has no character type, so a rune is emitted as a one character string
			return json_quote_string(val.str())
		}
		[]Value {
			if val.len == 0 {
				return '[]'
			}

			items := val.map(value_to_json_str)

			mut total_size := 0
			for s in items {
				total_size += s.len
			}

			mut sb := strings.new_builder(2 + total_size + items.len)
			sb.write_byte(91) // [
			sb.write_string(items.join(','))
			sb.write_byte(93) // ]

			return sb.str()
		}
		map[string]Value {
			if val.len == 0 {
				return '{}'
			}

			mut entries := []string{cap: val.len}
			mut total_size := 0
			for k, v in val {
				entry := '${json_quote_string(k)}:${value_to_json_str(v)}'
				total_size += entry.len
				entries << entry
			}

			// entries must be comma separated, or the object is unparseable
			mut sb := strings.new_builder(2 + total_size + entries.len)
			sb.write_byte(123) // {
			sb.write_string(entries.join(','))
			sb.write_byte(125) // }

			return sb.str()
		}
		Nested {
			return loggable_to_json_str(val.inner)
		}
		Err {
			return json_quote_string(val.inner.str())
		}
		Custom {
			return json_quote_string(val.inner.render())
		}
	}
}
