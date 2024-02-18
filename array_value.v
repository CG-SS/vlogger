module vlogger

pub struct ArrayValue {
	value []Value
}

fn (b ArrayValue) primitive_type() PrimitiveType {
	return PrimitiveType.array
}

fn (b ArrayValue) bool() bool {
	return default_bool_val
}

fn (b ArrayValue) string() string {
	return default_string_val
}

fn (b ArrayValue) i8() i8 {
	return default_int_val
}

fn (b ArrayValue) i16() i16 {
	return default_int_val
}

fn (b ArrayValue) int() int {
	return default_int_val
}

fn (b ArrayValue) i64() i64 {
	return default_int_val
}

fn (b ArrayValue) u8() u8 {
	return default_int_val
}

fn (b ArrayValue) u16() u16 {
	return default_int_val
}

fn (b ArrayValue) u32() u32 {
	return default_int_val
}

fn (b ArrayValue) u64() u64 {
	return default_int_val
}

fn (b ArrayValue) rune() rune {
	return default_int_val
}

fn (b ArrayValue) f32() f32 {
	return default_float_val
}

fn (b ArrayValue) f64() f64 {
	return default_float_val
}

fn (b ArrayValue) array() []Value {
	return b.value
}

fn (b ArrayValue) map() map[string]Value {
	return map[string]Value{}
}

fn (b ArrayValue) strut() Loggable {
	return default_loggable_val
}

fn (b ArrayValue) error() IError {
	return default_error
}
