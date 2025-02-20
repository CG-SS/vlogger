module vlogger

pub struct I8Value {
	value i8
}

fn (b I8Value) primitive_type() PrimitiveType {
	return PrimitiveType.i8
}

fn (b I8Value) bool() bool {
	return default_bool_val
}

fn (b I8Value) string() string {
	return default_string_val
}

fn (b I8Value) i8() i8 {
	return b.value
}

fn (b I8Value) i16() i16 {
	return default_int_val
}

fn (b I8Value) int() int {
	return default_int_val
}

fn (b I8Value) i64() i64 {
	return default_int_val
}

fn (b I8Value) u8() u8 {
	return default_int_val
}

fn (b I8Value) u16() u16 {
	return default_int_val
}

fn (b I8Value) u32() u32 {
	return default_int_val
}

fn (b I8Value) u64() u64 {
	return default_int_val
}

fn (b I8Value) rune() rune {
	return default_int_val
}

fn (b I8Value) f32() f32 {
	return default_float_val
}

fn (b I8Value) f64() f64 {
	return default_float_val
}

fn (b I8Value) array() []Value {
	return []
}

fn (b I8Value) map() map[string]Value {
	return map[string]Value{}
}

fn (b I8Value) strut() Loggable {
	return default_loggable_val
}

fn (b I8Value) error() IError {
	return default_error
}
