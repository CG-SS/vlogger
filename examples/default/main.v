module main

import vlogger
import os

struct LoggableStrut {
	name string
	age  i32
}

fn (l LoggableStrut) fields() []vlogger.Field {
	return [
		vlogger.Field{
			key:   'name'
			value: vlogger.StringValue{l.name}
		},
		vlogger.Field{
			key:   'age'
			value: vlogger.I32Value{l.age}
		},
	]
}

fn main() {
	mut out := os.stdout()
	defer { out.close() }

	logger := vlogger.default(mut out)
	defer { logger.close() }

	logger.trace().bool('hello', false).send()
	logger.debug().u8('number', 8).string('test', 'this is a test').f32('float_val', 3.66).send()
	logger.info().bool('hello', false).message('hello there')
	logger.warn().f64('number', 776.54323).message('another number')

	logger.error().strut('struct', LoggableStrut{
		name: 'John'
		age:  19
	}).send()
	logger.info().array('nodes', [vlogger.StringValue{'hello'},
		vlogger.StringValue{'there'}]).send()
	logger.fatal().err('error', error('failure')).send()
}
