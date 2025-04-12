module vlogger

import io
import strings

pub type ErrorHandlerFn = fn (IError)

pub fn write_json_message_fn(error_handler_fn ErrorHandlerFn, mut writer io.Writer) MessageWriterFn {
	return fn [mut writer, error_handler_fn] (msg Message) {
		msg_json_str := loggable_to_json_str(msg as Loggable)

		writer.write('${msg_json_str}\n'.bytes()) or { error_handler_fn(err) }
	}
}

fn loggable_to_json_str(loggable Loggable) string {
	fields_str := loggable.fields().map(field_to_json_str)

	mut sb := strings.new_builder(2)
	sb.write_string('{')
	sb.write_string(fields_str.join(','))
	sb.write_string('}')

	return sb.str()
}

fn field_to_json_str(field Field) string {
	mut sb := strings.new_builder(3)
	sb.write_string('"')
	sb.write_string(field.key)
	sb.write_string('":')
	sb.write_string(value_to_json_str(field.value))

	return sb.str()
}

fn value_to_json_str(val Value) string {
	match val.primitive_type() {
		.bool {
			if val.bool() {
				return 'true'
			} else {
				return 'false'
			}
		}
		.string {
			str_val := val.string()
			if str_val.len == 0 {
				return '""'
			} else {
				return '"${str_val}"'
			}
		}
		.i8 {
			return val.i8().str()
		}
		.u8 {
			return val.u8().str()
		}
		.i16 {
			return val.i16().str()
		}
		.u16 {
			return val.u16().str()
		}
		.i32 {
			return val.i32().str()
		}
		.u32 {
			return val.u32().str()
		}
		.i64 {
			return val.i64().str()
		}
		.u64 {
			return val.u64().str()
		}
		.rune {
			return val.rune().str()
		}
		.f32 {
			return val.f32().str()
		}
		.f64 {
			return val.f64().str()
		}
		.array {
			array_val := val.array().map(value_to_json_str)

			return '${array_val.join(',')}'
		}
		.map {
			mut sb := strings.new_builder(2)
			sb.write_string('{')
			for k, v in val.map() {
				sb.write_string('"')
				sb.write_string(k)
				sb.write_string('":')
				sb.write_string(value_to_json_str(v))
			}
			sb.write_string('}')

			return sb.str()
		}
		.strut {
			return loggable_to_json_str(val.strut())
		}
		.error {
			return '"${val.error().str()}"'
		}
	}
}
