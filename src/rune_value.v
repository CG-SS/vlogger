module vlogger

pub struct RuneValue {
pub:
	value rune
}

fn (_ RuneValue) primitive_type() PrimitiveType {
	return PrimitiveType.rune
}

fn (_ RuneValue) bool() bool {
	return default_bool_val
}

fn (_ RuneValue) string() string {
	return default_string_val
}

fn (_ RuneValue) i8() i8 {
	return default_int_val
}

fn (_ RuneValue) i16() i16 {
	return default_int_val
}

fn (_ RuneValue) i32() i32 {
	return default_int_val
}

fn (_ RuneValue) i64() i64 {
	return default_int_val
}

fn (_ RuneValue) u8() u8 {
	return default_int_val
}

fn (_ RuneValue) u16() u16 {
	return default_int_val
}

fn (_ RuneValue) u32() u32 {
	return default_int_val
}

fn (_ RuneValue) u64() u64 {
	return default_int_val
}

fn (r RuneValue) rune() rune {
	return r.value
}

fn (_ RuneValue) f32() f32 {
	return default_float_val
}

fn (_ RuneValue) f64() f64 {
	return default_float_val
}

fn (_ RuneValue) array() []Value {
	return default_array_val
}

fn (_ RuneValue) map() map[string]Value {
	return default_map_val
}

fn (_ RuneValue) strut() Loggable {
	return default_loggable_val
}

fn (_ RuneValue) error() IError {
	return default_error
}
