module vlogger

pub struct StrutValue {
pub:
	value Loggable
}

fn (_ StrutValue) primitive_type() PrimitiveType {
	return PrimitiveType.strut
}

fn (_ StrutValue) bool() bool {
	return default_bool_val
}

fn (_ StrutValue) string() string {
	return default_string_val
}

fn (_ StrutValue) i8() i8 {
	return default_int_val
}

fn (_ StrutValue) i16() i16 {
	return default_int_val
}

fn (_ StrutValue) i32() i32 {
	return default_int_val
}

fn (_ StrutValue) i64() i64 {
	return default_int_val
}

fn (_ StrutValue) u8() u8 {
	return default_int_val
}

fn (_ StrutValue) u16() u16 {
	return default_int_val
}

fn (_ StrutValue) u32() u32 {
	return default_int_val
}

fn (_ StrutValue) u64() u64 {
	return default_int_val
}

fn (_ StrutValue) rune() rune {
	return default_int_val
}

fn (_ StrutValue) f32() f32 {
	return default_float_val
}

fn (_ StrutValue) f64() f64 {
	return default_float_val
}

fn (_ StrutValue) array() []Value {
	return default_array_val
}

fn (_ StrutValue) map() map[string]Value {
	return default_map_val
}

fn (s StrutValue) strut() Loggable {
	return s.value
}

fn (_ StrutValue) error() IError {
	return default_error
}
