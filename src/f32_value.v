module vlogger

pub struct F32Value {
	value f32
}

fn (_ F32Value) primitive_type() PrimitiveType {
	return PrimitiveType.f32
}

fn (_ F32Value) bool() bool {
	return default_bool_val
}

fn (_ F32Value) string() string {
	return default_string_val
}

fn (_ F32Value) i8() i8 {
	return default_int_val
}

fn (_ F32Value) i16() i16 {
	return default_int_val
}

fn (_ F32Value) int() int {
	return default_int_val
}

fn (_ F32Value) i64() i64 {
	return default_int_val
}

fn (_ F32Value) u8() u8 {
	return default_int_val
}

fn (_ F32Value) u16() u16 {
	return default_int_val
}

fn (_ F32Value) u32() u32 {
	return default_int_val
}

fn (_ F32Value) u64() u64 {
	return default_int_val
}

fn (_ F32Value) rune() rune {
	return default_int_val
}

fn (f F32Value) f32() f32 {
	return f.value
}

fn (_ F32Value) f64() f64 {
	return default_float_val
}

fn (_ F32Value) array() []Value {
	return []
}

fn (_ F32Value) map() map[string]Value {
	return map[string]Value{}
}

fn (_ F32Value) strut() Loggable {
	return default_loggable_val
}

fn (_ F32Value) error() IError {
	return default_error
}
