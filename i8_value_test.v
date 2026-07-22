module vlogger

fn test_i8_value() {
	byte := i8(-5)
	val := I8Value{byte}

	assert val.array() == default_array_val
	assert val.bool() == default_bool_val
	assert val.string() == default_string_val
	assert val.i8() == byte
	assert val.i16() == default_int_val
	assert val.i32() == default_int_val
	assert val.i64() == default_int_val
	assert val.u8() == default_int_val
	assert val.u16() == default_int_val
	assert val.u32() == default_int_val
	assert val.u64() == default_int_val
	assert val.f32() == default_float_val
	assert val.f64() == default_float_val
	assert val.error() == default_error
	assert val.map() == default_map_val
	assert val.rune() == default_int_val
	assert val.strut() == Loggable(default_loggable_val)
}
