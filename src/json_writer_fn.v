module vlogger

import io
import strings

pub type ErrorHandlerFn = fn (IError)

pub fn write_json_message_fn(error_handler_fn ErrorHandlerFn, mut writer io.Writer) MessageWriterFn {
	return fn [mut writer, error_handler_fn] (msg Loggable) {
		msg_json_str := loggable_to_json_str(msg)

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
	field_key := field.key
	if field_key.is_blank() {
		return ''
	}

	mut sb := strings.new_builder(3)
	sb.write_string('"')
	sb.write_string(field_key)
	sb.write_string('":')
	sb.write_string(value_to_json_str(field.value))

	return sb.str()
}

struct MapValueTuple {
	key   string
	value string
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
				mut sb := strings.new_builder(2 + str_val.len)
				sb.write_byte(34) // "
				sb.write_string(str_val)
				sb.write_byte(34) // "

				return sb.str()
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
			array_val := val.array()
			if array_val.len == 0 {
				return '[]'
			} else {
				array_val_str := array_val.map(value_to_json_str)

				mut total_size := 0
				for s in array_val_str {
					total_size += s.len
				}
				mut sb := strings.new_builder(total_size + (array_val_str.len - 1))
				sb.write_byte(91) // [
				sb.write_string(array_val_str.join(','))
				sb.write_byte(93) // ]

				return sb.str()
			}
		}
		.map {
			val_map := val.map()
			if val_map.len == 0 {
				return '{}'
			} else {
				mut tuple_map := []MapValueTuple{cap: val_map.len}
				mut total_size := 0
				for k, v in val_map {
					total_size += k.len
					value_str := value_to_json_str(v)
					total_size += value_str.len

					tuple_map << MapValueTuple{
						key:   k
						value: value_str
					}
				}

				mut sb := strings.new_builder(2 + total_size + (3 * tuple_map.len))
				sb.write_byte(123) // {
				for tuple in tuple_map {
					sb.write_byte(34) // "
					sb.write_string(tuple.key)
					sb.write_byte(34) // "
					sb.write_byte(58) // :
					sb.write_string(tuple.value)
				}
				sb.write_byte(125) // }

				return sb.str()
			}
		}
		.strut {
			return loggable_to_json_str(val.strut())
		}
		.error {
			err_str := val.error().str()
			if err_str.len == 0 {
				return '""'
			} else {
				mut sb := strings.new_builder(2 + err_str.len)
				sb.write_byte(34) // "
				sb.write_string(err_str)
				sb.write_byte(34) // "

				return sb.str()
			}
		}
	}
}
