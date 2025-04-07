module vlogger

pub struct BoolValue {
	value bool
}

fn (_ BoolValue) primitive_type() PrimitiveType {
	return PrimitiveType.bool
}

fn (b BoolValue) bool() bool {
	return b.value
}

fn (_ BoolValue) string() string {
	return default_string_val
}

fn (_ BoolValue) i8() i8 {
	return default_int_val
}

fn (_ BoolValue) i16() i16 {
	return default_int_val
}

fn (_ BoolValue) int() int {
	return default_int_val
}

fn (_ BoolValue) i64() i64 {
	return default_int_val
}

fn (_ BoolValue) u8() u8 {
	return default_int_val
}

fn (_ BoolValue) u16() u16 {
	return default_int_val
}

fn (_ BoolValue) u32() u32 {
	return default_int_val
}

fn (_ BoolValue) u64() u64 {
	return default_int_val
}

fn (_ BoolValue) rune() rune {
	return default_int_val
}

fn (_ BoolValue) f32() f32 {
	return default_float_val
}

fn (_ BoolValue) f64() f64 {
	return default_float_val
}

fn (_ BoolValue) array() []Value {
	return []
}

fn (_ BoolValue) map() map[string]Value {
	return map[string]Value{}
}

fn (_ BoolValue) strut() Loggable {
	return default_loggable_val
}

fn (_ BoolValue) error() IError {
	return default_error
}
