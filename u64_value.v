module vlogger

pub struct U64Value {
	value u64
}

fn (_ U64Value) primitive_type() PrimitiveType {
	return PrimitiveType.u64
}

fn (_ U64Value) bool() bool {
	return default_bool_val
}

fn (_ U64Value) string() string {
	return default_string_val
}

fn (_ U64Value) i8() i8 {
	return default_int_val
}

fn (_ U64Value) i16() i16 {
	return default_int_val
}

fn (_ U64Value) int() int {
	return default_int_val
}

fn (_ U64Value) i64() i64 {
	return default_int_val
}

fn (_ U64Value) u8() u8 {
	return default_int_val
}

fn (_ U64Value) u16() u16 {
	return default_int_val
}

fn (_ U64Value) u32() u32 {
	return default_int_val
}

fn (u U64Value) u64() u64 {
	return u.value
}

fn (_ U64Value) rune() rune {
	return default_int_val
}

fn (_ U64Value) f32() f32 {
	return default_float_val
}

fn (_ U64Value) f64() f64 {
	return default_float_val
}

fn (_ U64Value) array() []Value {
	return []
}

fn (_ U64Value) map() map[string]Value {
	return map[string]Value{}
}

fn (_ U64Value) strut() Loggable {
	return default_loggable_val
}

fn (_ U64Value) error() IError {
	return default_error
}
