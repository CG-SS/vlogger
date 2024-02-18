module vlogger

pub struct ErrorValue {
	value IError
}

fn (b ErrorValue) primitive_type() PrimitiveType {
	return PrimitiveType.error
}

fn (b ErrorValue) bool() bool {
	return default_bool_val
}

fn (b ErrorValue) string() string {
	return default_string_val
}

fn (b ErrorValue) i8() i8 {
	return default_int_val
}

fn (b ErrorValue) i16() i16 {
	return default_int_val
}

fn (b ErrorValue) int() int {
	return default_int_val
}

fn (b ErrorValue) i64() i64 {
	return default_int_val
}

fn (b ErrorValue) u8() u8 {
	return default_int_val
}

fn (b ErrorValue) u16() u16 {
	return default_int_val
}

fn (b ErrorValue) u32() u32 {
	return default_int_val
}

fn (b ErrorValue) u64() u64 {
	return default_int_val
}

fn (b ErrorValue) rune() rune {
	return default_int_val
}

fn (b ErrorValue) f32() f32 {
	return default_float_val
}

fn (b ErrorValue) f64() f64 {
	return default_float_val
}

fn (b ErrorValue) array() []Value {
	return []
}

fn (b ErrorValue) map() map[string]Value {
	return map[string]Value{}
}

fn (b ErrorValue) strut() Loggable {
	return default_loggable_val
}

fn (b ErrorValue) error() IError {
	return b.value
}