module vlogger

pub struct StrutValue {
	value Loggable
}

fn (b StrutValue) primitive_type() PrimitiveType {
	return PrimitiveType.strut
}

fn (b StrutValue) bool() bool {
	return default_bool_val
}

fn (b StrutValue) string() string {
	return default_string_val
}

fn (b StrutValue) i8() i8 {
	return default_int_val
}

fn (b StrutValue) i16() i16 {
	return default_int_val
}

fn (b StrutValue) int() int {
	return default_int_val
}

fn (b StrutValue) i64() i64 {
	return default_int_val
}

fn (b StrutValue) u8() u8 {
	return default_int_val
}

fn (b StrutValue) u16() u16 {
	return default_int_val
}

fn (b StrutValue) u32() u32 {
	return default_int_val
}

fn (b StrutValue) u64() u64 {
	return default_int_val
}

fn (b StrutValue) rune() rune {
	return default_int_val
}

fn (b StrutValue) f32() f32 {
	return default_float_val
}

fn (b StrutValue) f64() f64 {
	return default_float_val
}

fn (b StrutValue) array() []Value {
	return []
}

fn (b StrutValue) map() map[string]Value {
	return map[string]Value{}
}

fn (b StrutValue) strut() Loggable {
	return b.value
}

fn (b StrutValue) error() IError {
	return default_error
}
