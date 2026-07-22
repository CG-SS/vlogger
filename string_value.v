module vlogger

pub struct StringValue {
pub:
	value string
}

fn (_ StringValue) primitive_type() PrimitiveType {
	return PrimitiveType.string
}

fn (_ StringValue) bool() bool {
	return default_bool_val
}

fn (s StringValue) string() string {
	return s.value
}

fn (_ StringValue) i8() i8 {
	return default_int_val
}

fn (_ StringValue) i16() i16 {
	return default_int_val
}

fn (_ StringValue) i32() i32 {
	return default_int_val
}

fn (_ StringValue) i64() i64 {
	return default_int_val
}

fn (_ StringValue) u8() u8 {
	return default_int_val
}

fn (_ StringValue) u16() u16 {
	return default_int_val
}

fn (_ StringValue) u32() u32 {
	return default_int_val
}

fn (_ StringValue) u64() u64 {
	return default_int_val
}

fn (_ StringValue) rune() rune {
	return default_int_val
}

fn (_ StringValue) f32() f32 {
	return default_float_val
}

fn (_ StringValue) f64() f64 {
	return default_float_val
}

fn (_ StringValue) array() []Value {
	return default_array_val
}

fn (_ StringValue) map() map[string]Value {
	return default_map_val
}

fn (_ StringValue) strut() Loggable {
	return default_loggable_val
}

fn (_ StringValue) error() IError {
	return default_error
}
