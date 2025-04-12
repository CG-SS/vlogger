module vlogger

pub struct ErrorValue {
pub:
	value IError
}

fn (_ ErrorValue) primitive_type() PrimitiveType {
	return PrimitiveType.error
}

fn (_ ErrorValue) bool() bool {
	return default_bool_val
}

fn (_ ErrorValue) string() string {
	return default_string_val
}

fn (_ ErrorValue) i8() i8 {
	return default_int_val
}

fn (_ ErrorValue) i16() i16 {
	return default_int_val
}

fn (_ ErrorValue) i32() i32 {
	return default_int_val
}

fn (_ ErrorValue) i64() i64 {
	return default_int_val
}

fn (_ ErrorValue) u8() u8 {
	return default_int_val
}

fn (_ ErrorValue) u16() u16 {
	return default_int_val
}

fn (_ ErrorValue) u32() u32 {
	return default_int_val
}

fn (_ ErrorValue) u64() u64 {
	return default_int_val
}

fn (_ ErrorValue) rune() rune {
	return default_int_val
}

fn (_ ErrorValue) f32() f32 {
	return default_float_val
}

fn (_ ErrorValue) f64() f64 {
	return default_float_val
}

fn (_ ErrorValue) array() []Value {
	return default_array_val
}

fn (_ ErrorValue) map() map[string]Value {
	return default_map_val
}

fn (_ ErrorValue) strut() Loggable {
	return default_loggable_val
}

fn (e ErrorValue) error() IError {
	return e.value
}
