module vlogger

pub struct IntValue {
	value int
}

fn (b IntValue) primitive_type() PrimitiveType {
	return PrimitiveType.int
}

fn (b IntValue) bool() bool {
	return default_bool_val
}

fn (b IntValue) string() string {
	return default_string_val
}

fn (b IntValue) i8() i8 {
	return default_int_val
}

fn (b IntValue) i16() i16 {
	return default_int_val
}

fn (b IntValue) int() int {
	return b.value
}

fn (b IntValue) i64() i64 {
	return default_int_val
}

fn (b IntValue) u8() u8 {
	return default_int_val
}

fn (b IntValue) u16() u16 {
	return default_int_val
}

fn (b IntValue) u32() u32 {
	return default_int_val
}

fn (b IntValue) u64() u64 {
	return default_int_val
}

fn (b IntValue) rune() rune {
	return default_int_val
}

fn (b IntValue) f32() f32 {
	return default_float_val
}

fn (b IntValue) f64() f64 {
	return default_float_val
}

fn (b IntValue) array() []Value {
	return []
}

fn (b IntValue) map() map[string]Value {
	return map[string]Value{}
}

fn (b IntValue) strut() Loggable {
	return default_loggable_val
}

fn (b IntValue) error() IError {
	return default_error
}