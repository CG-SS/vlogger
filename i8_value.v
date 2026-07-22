module vlogger

pub struct I8Value {
pub:
	value i8
}

fn (_ I8Value) primitive_type() PrimitiveType {
	return PrimitiveType.i8
}

fn (_ I8Value) bool() bool {
	return default_bool_val
}

fn (_ I8Value) string() string {
	return default_string_val
}

fn (i I8Value) i8() i8 {
	return i.value
}

fn (_ I8Value) i16() i16 {
	return default_int_val
}

fn (_ I8Value) i32() i32 {
	return default_int_val
}

fn (_ I8Value) i64() i64 {
	return default_int_val
}

fn (_ I8Value) u8() u8 {
	return default_int_val
}

fn (_ I8Value) u16() u16 {
	return default_int_val
}

fn (_ I8Value) u32() u32 {
	return default_int_val
}

fn (_ I8Value) u64() u64 {
	return default_int_val
}

fn (_ I8Value) rune() rune {
	return default_int_val
}

fn (_ I8Value) f32() f32 {
	return default_float_val
}

fn (_ I8Value) f64() f64 {
	return default_float_val
}

fn (_ I8Value) array() []Value {
	return default_array_val
}

fn (_ I8Value) map() map[string]Value {
	return default_map_val
}

fn (_ I8Value) strut() Loggable {
	return default_loggable_val
}

fn (_ I8Value) error() IError {
	return default_error
}
