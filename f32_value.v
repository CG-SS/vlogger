module vlogger

pub struct F32Value {
	value f32
}

fn (b F32Value) primitive_type() PrimitiveType {
	return PrimitiveType.f32
}

fn (b F32Value) bool() bool {
	return default_bool_val
}

fn (b F32Value) string() string {
	return default_string_val
}

fn (b F32Value) i8() i8 {
	return default_int_val
}

fn (b F32Value) i16() i16 {
	return default_int_val
}

fn (b F32Value) int() int {
	return default_int_val
}

fn (b F32Value) i64() i64 {
	return default_int_val
}

fn (b F32Value) u8() u8 {
	return default_int_val
}

fn (b F32Value) u16() u16 {
	return default_int_val
}

fn (b F32Value) u32() u32 {
	return default_int_val
}

fn (b F32Value) u64() u64 {
	return default_int_val
}

fn (b F32Value) rune() rune {
	return default_int_val
}

fn (b F32Value) f32() f32 {
	return b.value
}

fn (b F32Value) f64() f64 {
	return default_float_val
}

fn (b F32Value) array() []Value {
	return []
}

fn (b F32Value) map() map[string]Value {
	return map[string]Value{}
}

fn (b F32Value) strut() Loggable {
	return default_loggable_val
}

fn (b F32Value) error() IError {
	return default_error
}
