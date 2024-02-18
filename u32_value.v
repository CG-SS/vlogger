module vlogger

pub struct U32Value {
	value u32
}

fn (b U32Value) primitive_type() PrimitiveType {
	return PrimitiveType.u32
}

fn (b U32Value) bool() bool {
	return default_bool_val
}

fn (b U32Value) string() string {
	return default_string_val
}

fn (b U32Value) i8() i8 {
	return default_int_val
}

fn (b U32Value) i16() i16 {
	return default_int_val
}

fn (b U32Value) int() int {
	return default_int_val
}

fn (b U32Value) i64() i64 {
	return default_int_val
}

fn (b U32Value) u8() u8 {
	return default_int_val
}

fn (b U32Value) u16() u16 {
	return default_int_val
}

fn (b U32Value) u32() u32 {
	return b.value
}

fn (b U32Value) u64() u64 {
	return default_int_val
}

fn (b U32Value) rune() rune {
	return default_int_val
}

fn (b U32Value) f32() f32 {
	return default_float_val
}

fn (b U32Value) f64() f64 {
	return default_float_val
}

fn (b U32Value) array() []Value {
	return []
}

fn (b U32Value) map() map[string]Value {
	return map[string]Value{}
}

fn (b U32Value) strut() Loggable {
	return default_loggable_val
}

fn (b U32Value) error() IError {
	return default_error
}
