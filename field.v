module vlogger

const default_string_value = ''

const default_bool_value = false

const default_int_value = 0

const default_float_value = 0.0

const default_struct_value = DefaultStructField{}

const default_array_value = []Field{}

const default_string_map_value = map[string]Field{}

pub interface Field {
	key string
	get_bool() bool
	get_string() string
	get_i8() i8
	get_u8() u8
	get_i16() i16
	get_u16() u16
	get_int() int
	get_u32() u32
	get_i64() i64
	get_u64() u64
	get_rune() rune
	get_f32() f32
	get_f64() f64
	get_isize() isize
	get_usize() usize
	get_struct() StructField
	get_array() []Field
	get_string_map() map[string]Field
}

interface StructField {
	get_fields() []Field
}

struct DefaultStructField {}

fn (d DefaultStructField) get_fields() []Field {
	return vlogger.default_array_value
}

struct BoolField {
	value bool
	key   string
}

fn (b BoolField) get_bool() bool {
	return b.value
}

fn (b BoolField) get_string() string {
	return vlogger.default_string_value
}

fn (b BoolField) get_i8() i8 {
	return vlogger.default_int_value
}

fn (b BoolField) get_u8() u8 {
	return vlogger.default_int_value
}

fn (b BoolField) get_i16() i16 {
	return vlogger.default_int_value
}

fn (b BoolField) get_u16() u16 {
	return vlogger.default_int_value
}

fn (b BoolField) get_int() int {
	return vlogger.default_int_value
}

fn (b BoolField) get_u32() u32 {
	return vlogger.default_int_value
}

fn (b BoolField) get_i64() i64 {
	return vlogger.default_int_value
}

fn (b BoolField) get_u64() u64 {
	return vlogger.default_int_value
}

fn (b BoolField) get_rune() rune {
	return vlogger.default_int_value
}

fn (b BoolField) get_f32() f32 {
	return vlogger.default_float_value
}

fn (b BoolField) get_f64() f64 {
	return vlogger.default_float_value
}

fn (b BoolField) get_isize() isize {
	return vlogger.default_int_value
}

fn (b BoolField) get_usize() usize {
	return vlogger.default_int_value
}

fn (b BoolField) get_struct() StructField {
	return vlogger.default_struct_value
}

fn (b BoolField) get_array() []Field {
	return vlogger.default_array_value
}

fn (b BoolField) get_string_map() map[string]Field {
	return vlogger.default_string_map_value
}
