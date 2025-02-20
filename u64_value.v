module vlogger

pub struct U64Value {
	value u64
}

fn (b U64Value) primitive_type() PrimitiveType {
	return PrimitiveType.u64
}

fn (b U64Value) bool() bool {
	return default_bool_val
}

fn (b U64Value) string() string {
	return default_string_val
}

fn (b U64Value) i8() i8 {
	return default_int_val
}

fn (b U64Value) i16() i16 {
	return default_int_val
}

fn (b U64Value) int() int {
	return default_int_val
}

fn (b U64Value) i64() i64 {
	return default_int_val
}

fn (b U64Value) u8() u8 {
	return default_int_val
}

fn (b U64Value) u16() u16 {
	return default_int_val
}

fn (b U64Value) u32() u32 {
	return default_int_val
}

fn (b U64Value) u64() u64 {
	return b.value
}

fn (b U64Value) rune() rune {
	return default_int_val
}

fn (b U64Value) f32() f32 {
	return default_float_val
}

fn (b U64Value) f64() f64 {
	return default_float_val
}

fn (b U64Value) array() []Value {
	return []
}

fn (b U64Value) map() map[string]Value {
	return map[string]Value{}
}

fn (b U64Value) strut() Loggable {
	return default_loggable_val
}

fn (b U64Value) error() IError {
	return default_error
}