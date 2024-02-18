module vlogger

pub struct MapValue {
	value map[string]Value
}

fn (b MapValue) primitive_type() PrimitiveType {
	return PrimitiveType.map
}

fn (b MapValue) bool() bool {
	return default_bool_val
}

fn (b MapValue) string() string {
	return default_string_val
}

fn (b MapValue) i8() i8 {
	return default_int_val
}

fn (b MapValue) i16() i16 {
	return default_int_val
}

fn (b MapValue) int() int {
	return default_int_val
}

fn (b MapValue) i64() i64 {
	return default_int_val
}

fn (b MapValue) u8() u8 {
	return default_int_val
}

fn (b MapValue) u16() u16 {
	return default_int_val
}

fn (b MapValue) u32() u32 {
	return default_int_val
}

fn (b MapValue) u64() u64 {
	return default_int_val
}

fn (b MapValue) rune() rune {
	return default_int_val
}

fn (b MapValue) f32() f32 {
	return default_float_val
}

fn (b MapValue) f64() f64 {
	return default_float_val
}

fn (b MapValue) array() []Value {
	return []
}

fn (b MapValue) map() map[string]Value {
	return b.value
}

fn (b MapValue) strut() Loggable {
	return default_loggable_val
}

fn (b MapValue) error() IError {
	return default_error
}

