module vlogger

pub struct U16Value {
	value u16
}

fn (b U16Value) primitive_type() PrimitiveType {
	return PrimitiveType.u16
}

fn (b U16Value) bool() bool {
	return default_bool_val
}

fn (b U16Value) string() string {
	return default_string_val
}

fn (b U16Value) i8() i8 {
	return default_int_val
}

fn (b U16Value) i16() i16 {
	return default_int_val
}

fn (b U16Value) int() int {
	return default_int_val
}

fn (b U16Value) i64() i64 {
	return default_int_val
}

fn (b U16Value) u8() u8 {
	return default_int_val
}

fn (b U16Value) u16() u16 {
	return b.value
}

fn (b U16Value) u32() u32 {
	return default_int_val
}

fn (b U16Value) u64() u64 {
	return default_int_val
}

fn (b U16Value) rune() rune {
	return default_int_val
}

fn (b U16Value) f32() f32 {
	return default_float_val
}

fn (b U16Value) f64() f64 {
	return default_float_val
}

fn (b U16Value) array() []Value {
	return []
}

fn (b U16Value) map() map[string]Value {
	return map[string]Value{}
}

fn (b U16Value) strut() Loggable {
	return default_loggable_val
}

fn (b U16Value) error() IError {
	return default_error
}
