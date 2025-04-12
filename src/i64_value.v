module vlogger

pub struct I64Value {
pub:
	value i64
}

fn (_ I64Value) primitive_type() PrimitiveType {
	return PrimitiveType.i64
}

fn (_ I64Value) bool() bool {
	return default_bool_val
}

fn (_ I64Value) string() string {
	return default_string_val
}

fn (_ I64Value) i8() i8 {
	return default_int_val
}

fn (_ I64Value) i16() i16 {
	return default_int_val
}

fn (_ I64Value) i32() i32 {
	return default_int_val
}

fn (i I64Value) i64() i64 {
	return i.value
}

fn (_ I64Value) u8() u8 {
	return default_int_val
}

fn (_ I64Value) u16() u16 {
	return default_int_val
}

fn (_ I64Value) u32() u32 {
	return default_int_val
}

fn (_ I64Value) u64() u64 {
	return default_int_val
}

fn (_ I64Value) rune() rune {
	return default_int_val
}

fn (_ I64Value) f32() f32 {
	return default_float_val
}

fn (_ I64Value) f64() f64 {
	return default_float_val
}

fn (_ I64Value) array() []Value {
	return default_array_val
}

fn (_ I64Value) map() map[string]Value {
	return default_map_val
}

fn (_ I64Value) strut() Loggable {
	return default_loggable_val
}

fn (_ I64Value) error() IError {
	return default_error
}
