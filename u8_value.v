module vlogger

pub struct U8Value {
	value u8
}

fn (b U8Value) primitive_type() PrimitiveType {
	return PrimitiveType.u8
}

fn (b U8Value) bool() bool {
	return default_bool_val
}

fn (b U8Value) string() string {
	return default_string_val
}

fn (b U8Value) i8() i8 {
	return default_int_val
}

fn (b U8Value) i16() i16 {
	return default_int_val
}

fn (b U8Value) int() int {
	return default_int_val
}

fn (b U8Value) i64() i64 {
	return default_int_val
}

fn (b U8Value) u8() u8 {
	return b.value
}

fn (b U8Value) u16() u16 {
	return default_int_val
}

fn (b U8Value) u32() u32 {
	return default_int_val
}

fn (b U8Value) u64() u64 {
	return default_int_val
}

fn (b U8Value) rune() rune {
	return default_int_val
}

fn (b U8Value) f32() f32 {
	return default_float_val
}

fn (b U8Value) f64() f64 {
	return default_float_val
}

fn (b U8Value) array() []Value {
	return []
}

fn (b U8Value) map() map[string]Value {
	return map[string]Value{}
}

fn (b U8Value) strut() Loggable {
	return default_loggable_val
}

fn (b U8Value) error() IError {
	return default_error
}

