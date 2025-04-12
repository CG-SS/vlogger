module vlogger

pub struct MapValue {
pub:
	value map[string]Value
}

fn (_ MapValue) primitive_type() PrimitiveType {
	return PrimitiveType.map
}

fn (_ MapValue) bool() bool {
	return default_bool_val
}

fn (_ MapValue) string() string {
	return default_string_val
}

fn (_ MapValue) i8() i8 {
	return default_int_val
}

fn (_ MapValue) i16() i16 {
	return default_int_val
}

fn (_ MapValue) i32() i32 {
	return default_int_val
}

fn (_ MapValue) i64() i64 {
	return default_int_val
}

fn (_ MapValue) u8() u8 {
	return default_int_val
}

fn (_ MapValue) u16() u16 {
	return default_int_val
}

fn (_ MapValue) u32() u32 {
	return default_int_val
}

fn (_ MapValue) u64() u64 {
	return default_int_val
}

fn (_ MapValue) rune() rune {
	return default_int_val
}

fn (_ MapValue) f32() f32 {
	return default_float_val
}

fn (_ MapValue) f64() f64 {
	return default_float_val
}

fn (_ MapValue) array() []Value {
	return default_array_val
}

fn (m MapValue) map() map[string]Value {
	return m.value
}

fn (_ MapValue) strut() Loggable {
	return default_loggable_val
}

fn (_ MapValue) error() IError {
	return default_error
}
