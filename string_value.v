module vlogger

pub struct StringValue {
	value string
}

fn (b StringValue) primitive_type() PrimitiveType {
	return PrimitiveType.string
}

fn (b StringValue) bool() bool {
	return default_bool_val
}

fn (b StringValue) string() string {
	return b.string
}

fn (b StringValue) i8() i8 {
	return default_int_val
}

fn (b StringValue) i16() i16 {
	return default_int_val
}

fn (b StringValue) int() int {
	return default_int_val
}

fn (b StringValue) i64() i64 {
	return default_int_val
}

fn (b StringValue) u8() u8 {
	return default_int_val
}

fn (b StringValue) u16() u16 {
	return default_int_val
}

fn (b StringValue) u32() u32 {
	return default_int_val
}

fn (b StringValue) u64() u64 {
	return default_int_val
}

fn (b StringValue) rune() rune {
	return default_int_val
}

fn (b StringValue) f32() f32 {
	return default_float_val
}

fn (b StringValue) f64() f64 {
	return default_float_val
}

fn (b StringValue) array() []Value {
	return []
}

fn (b StringValue) map() map[string]Value {
	return map[string]Value{}
}

fn (b StringValue) strut() Loggable {
	return default_loggable_val
}

fn (b StringValue) error() IError {
	return default_error
}