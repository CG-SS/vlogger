module vlogger

import strings
import json

struct LoggableStrut {
	name string
	age  i32
}

fn (l LoggableStrut) fields() []Field {
	return [
		Field{
			key:   'name'
			value: StringValue{l.name}
		},
		Field{
			key:   'age'
			value: I32Value{l.age}
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
				value: I32Value{39}
			},
			Field{
				key:   'node_name'
				value: StringValue{'root'}
			},
			Field{
				key:   'accuracy'
				value: F32Value{98.6}
			},
			Field{
				key:   'obj'
				value: StrutValue{LoggableStrut{
					name: 'john'
					age:  19
				}}
			},
			Field{
				key:   'array'
				value: ArrayValue{[
					F64Value{786.443},
					BoolValue{true},
				]}
			},
			Field{
				key:   'money'
				value: I64Value{532803274382056}
			},
			Field{
				key:   'err'
				value: ErrorValue{error('this is an error')}
			},
			Field{
				key:   'i8_val'
				value: I8Value{-6}
			},
			Field{
				key:   'i16_val'
				value: I16Value{-7953}
			},
			Field{
				key:   'u8_val'
				value: U8Value{201}
			},
			Field{
				key:   'u16_val'
				value: U16Value{6843}
			},
			Field{
				key:   'u32_val'
				value: U32Value{1649233}
			},
			Field{
				key:   'u64_val'
				value: U64Value{1649233542109}
			},
		]
	}

	mut sb := strings.new_builder(0)
	writer_fn := write_json_message_fn(fn (_ IError) {}, mut sb)
	writer_fn(test_fields)

	output := json.decode(JsonWriteTestOutput, sb.str()) or {
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
