module vlogger

pub struct U32Value {
pub:
	value u32
}

fn (_ U32Value) primitive_type() PrimitiveType {
	return PrimitiveType.u32
}

fn (_ U32Value) bool() bool {
	return default_bool_val
}

fn (_ U32Value) string() string {
	return default_string_val
}

fn (_ U32Value) i8() i8 {
	return default_int_val
}

fn (_ U32Value) i16() i16 {
	return default_int_val
}

fn (_ U32Value) i32() i32 {
	return default_int_val
}

fn (_ U32Value) i64() i64 {
	return default_int_val
}

fn (_ U32Value) u8() u8 {
	return default_int_val
}

fn (_ U32Value) u16() u16 {
	return default_int_val
}

fn (u U32Value) u32() u32 {
	return u.value
}

fn (_ U32Value) u64() u64 {
	return default_int_val
}

fn (_ U32Value) rune() rune {
	return default_int_val
}

fn (_ U32Value) f32() f32 {
	return default_float_val
}

fn (_ U32Value) f64() f64 {
	return default_float_val
}

fn (_ U32Value) array() []Value {
	return default_array_val
}

fn (_ U32Value) map() map[string]Value {
	return default_map_val
}

fn (_ U32Value) strut() Loggable {
	return default_loggable_val
}

fn (_ U32Value) error() IError {
	return default_error
}
