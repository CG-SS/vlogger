module vlogger

pub struct I16Value {
	value i16
}

fn (b I16Value) primitive_type() PrimitiveType {
	return PrimitiveType.i16
}

fn (b I16Value) bool() bool {
	return default_bool_val
}

fn (b I16Value) string() string {
	return default_string_val
}

fn (b I16Value) i8() i8 {
	return default_int_val
}

fn (b I16Value) i16() i16 {
	return b.value
}

fn (b I16Value) int() int {
	return default_int_val
}

fn (b I16Value) i64() i64 {
	return default_int_val
}

fn (b I16Value) u8() u8 {
	return default_int_val
}

fn (b I16Value) u16() u16 {
	return default_int_val
}

fn (b I16Value) u32() u32 {
	return default_int_val
}

fn (b I16Value) u64() u64 {
	return default_int_val
}

fn (b I16Value) rune() rune {
	return default_int_val
}

fn (b I16Value) f32() f32 {
	return default_float_val
}

fn (b I16Value) f64() f64 {
	return default_float_val
}

fn (b I16Value) array() []Value {
	return []
}

fn (b I16Value) map() map[string]Value {
	return map[string]Value{}
}

fn (b I16Value) strut() Loggable {
	return default_loggable_val
}

fn (b I16Value) error() IError {
	return default_error
}
