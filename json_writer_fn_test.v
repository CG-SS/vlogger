module vlogger

import strings
import json2

struct LoggableStrut {
	name string
	age  i32
}

fn (l LoggableStrut) fields() []Field {
	return [
		Field{
			key:   'name'
			value: l.name
		},
		Field{
			key:   'age'
			value: i32(l.age)
		},
	]
}

type JsonArrayTypes = f64 | bool

struct JsonWriteTestOutput {
	count     i32
	node_name string
	accuracy  f32
	obj       LoggableStrut
	array     []JsonArrayTypes
	money     i64
	err       string
	i8_val    i8
	i16_val   i16
	u8_val    u8
	u16_val   i16
	u32_val   i32
	u64_val   i64
}

struct TestFields {
	ar []Field
}

fn (t TestFields) fields() []Field {
	return t.ar
}

fn test_write_json_message_fn_successful() {
	test_fields := TestFields{
		ar: [
			Field{
				key:   'count'
				value: i32(39)
			},
			Field{
				key:   'node_name'
				value: 'root'
			},
			Field{
				key:   'accuracy'
				value: f32(98.6)
			},
			Field{
				key:   'obj'
				value: Nested{LoggableStrut{
					name: 'john'
					age:  19
				}}
			},
			Field{
				key:   'array'
				value: [
					Value(f64(786.443)),
					Value(true),
				]
			},
			Field{
				key:   'money'
				value: i64(532803274382056)
			},
			Field{
				key:   'err'
				value: Err{error('this is an error')}
			},
			Field{
				key:   'i8_val'
				value: i8(-6)
			},
			Field{
				key:   'i16_val'
				value: i16(-7953)
			},
			Field{
				key:   'u8_val'
				value: u8(201)
			},
			Field{
				key:   'u16_val'
				value: u16(6843)
			},
			Field{
				key:   'u32_val'
				value: u32(1649233)
			},
			Field{
				key:   'u64_val'
				value: u64(1649233542109)
			},
		]
	}

	mut sb := strings.new_builder(0)
	writer_fn := write_json_message_fn(fn (_ IError) {}, mut sb)
	writer_fn(test_fields)

	output := json2.decode[JsonWriteTestOutput](sb.str()) or {
		assert false, 'failed json decode: ${err}'
		return
	}

	assert output.count == 39
	assert output.node_name == 'root'
	assert output.accuracy == 98.6
	assert output.obj.name == 'john'
	assert output.obj.age == 19

	assert output.array.len == 2
	match output.array[0] {
		f64 {
			assert output.array[0] as f64 == 786.443
		}
		bool {
			assert false, 'should be a f64'
		}
	}

	match output.array[1] {
		f64 {
			assert false, 'should be a bool'
		}
		bool {
			assert output.array[1] as bool == true
		}
	}

	assert output.money == 532803274382056
	assert output.err == 'this is an error'
	assert output.i8_val == -6
	assert output.i16_val == -7953
	assert output.u8_val == 201
	assert output.u16_val == 6843
	assert output.u32_val == 1649233
	assert output.u64_val == 1649233542109
}
