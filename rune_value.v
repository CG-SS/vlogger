module vlogger

pub struct RuneValue {
	value rune
}

fn (b RuneValue) primitive_type() PrimitiveType {
	return PrimitiveType.rune
}

fn (b RuneValue) bool() bool {
	return default_bool_val
}

fn (b RuneValue) string() string {
	return default_string_val
}

fn (b RuneValue) i8() i8 {
	return default_int_val
}

fn (b RuneValue) i16() i16 {
	return default_int_val
}

fn (b RuneValue) int() int {
	return default_int_val
}

fn (b RuneValue) i64() i64 {
	return default_int_val
}

fn (b RuneValue) u8() u8 {
	return default_int_val
}

fn (b RuneValue) u16() u16 {
	return default_int_val
}

fn (b RuneValue) u32() u32 {
	return default_int_val
}

fn (b RuneValue) u64() u64 {
	return default_int_val
}

fn (b RuneValue) rune() rune {
	return b.rune
}

fn (b RuneValue) f32() f32 {
	return default_float_val
}

fn (b RuneValue) f64() f64 {
	return default_float_val
}

fn (b RuneValue) array() []Value {
	return []
}

fn (b RuneValue) map() map[string]Value {
	return map[string]Value{}
}

fn (b RuneValue) strut() Loggable {
	return default_loggable_val
}

fn (b RuneValue) error() IError {
	return default_error
}

