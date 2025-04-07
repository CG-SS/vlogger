module vlogger

pub struct ArrayValue {
	value []Value
}

fn (_ ArrayValue) primitive_type() PrimitiveType {
	return PrimitiveType.array
}

fn (_ ArrayValue) bool() bool {
	return default_bool_val
}

fn (_ ArrayValue) string() string {
	return default_string_val
}

fn (_ ArrayValue) i8() i8 {
	return default_int_val
}

fn (_ ArrayValue) i16() i16 {
	return default_int_val
}

fn (_ ArrayValue) int() int {
	return default_int_val
}

fn (_ ArrayValue) i64() i64 {
	return default_int_val
}

fn (_ ArrayValue) u8() u8 {
	return default_int_val
}

fn (_ ArrayValue) u16() u16 {
	return default_int_val
}

fn (_ ArrayValue) u32() u32 {
	return default_int_val
}

fn (_ ArrayValue) u64() u64 {
	return default_int_val
}

fn (_ ArrayValue) rune() rune {
	return default_int_val
}

fn (_ ArrayValue) f32() f32 {
	return default_float_val
}

fn (_ ArrayValue) f64() f64 {
	return default_float_val
}

fn (b ArrayValue) array() []Value {
	return b.value
}

fn (_ ArrayValue) map() map[string]Value {
	return map[string]Value{}
}

fn (_ ArrayValue) strut() Loggable {
	return default_loggable_val
}

fn (_ ArrayValue) error() IError {
	return default_error
}
