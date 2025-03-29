module vlogger

pub struct IntValue {
	value int
}

fn (_ IntValue) primitive_type() PrimitiveType {
	return PrimitiveType.int
}

fn (_ IntValue) bool() bool {
	return default_bool_val
}

fn (_ IntValue) string() string {
	return default_string_val
}

fn (_ IntValue) i8() i8 {
	return default_int_val
}

fn (_ IntValue) i16() i16 {
	return default_int_val
}

fn (i IntValue) int() int {
	return i.value
}

fn (_ IntValue) i64() i64 {
	return default_int_val
}

fn (_ IntValue) u8() u8 {
	return default_int_val
}

fn (_ IntValue) u16() u16 {
	return default_int_val
}

fn (_ IntValue) u32() u32 {
	return default_int_val
}

fn (_ IntValue) u64() u64 {
	return default_int_val
}

fn (_ IntValue) rune() rune {
	return default_int_val
}

fn (_ IntValue) f32() f32 {
	return default_float_val
}

fn (_ IntValue) f64() f64 {
	return default_float_val
}

fn (_ IntValue) array() []Value {
	return []
}

fn (_ IntValue) map() map[string]Value {
	return map[string]Value{}
}

fn (_ IntValue) strut() Loggable {
	return default_loggable_val
}

fn (_ IntValue) error() IError {
	return default_error
}
