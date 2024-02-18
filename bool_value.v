module vlogger

pub struct BoolValue {
	value bool
}

fn (b BoolValue) primitive_type() PrimitiveType {
	return PrimitiveType.bool
}

fn (b BoolValue) bool() bool {
	return b.value
}

fn (b BoolValue) string() string {
	return default_string_val
}

fn (b BoolValue) i8() i8 {
	return default_int_val
}

fn (b BoolValue) i16() i16 {
	return default_int_val
}

fn (b BoolValue) int() int {
	return default_int_val
}

fn (b BoolValue) i64() i64 {
	return default_int_val
}

fn (b BoolValue) u8() u8 {
	return default_int_val
}

fn (b BoolValue) u16() u16 {
	return default_int_val
}

fn (b BoolValue) u32() u32 {
	return default_int_val
}

fn (b BoolValue) u64() u64 {
	return default_int_val
}

fn (b BoolValue) rune() rune {
	return default_int_val
}

fn (b BoolValue) f32() f32 {
	return default_float_val
}

fn (b BoolValue) f64() f64 {
	return default_float_val
}

fn (b BoolValue) array() []Value {
	return []
}

fn (b BoolValue) map() map[string]Value {
	return map[string]Value{}
}

fn (b BoolValue) strut() Loggable {
	return default_loggable_val
}

fn (b BoolValue) error() IError {
	return default_error
}

