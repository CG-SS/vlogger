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
			value: l.name
		},
		vlogger.Field{
			key:   'age'
			value: l.age
		},
	]
}

struct Ip {
	octets []u8
}

fn (i Ip) render() string {
	return i.octets.map(it.str()).join('.')
}

fn main() {
	mut out := os.stdout()
	defer { out.close() }

	// NOTE: `vlogger.default(mut out)` is the quickest way to get a logger, but it
	// hardcodes the message level to `.info`, so any `trace()` and `debug()` calls
	// are silently discarded by the level filter.
	//
	// To see them, build the logger with `new()` and lower the level explicitly.
	// Levels are ordered: none < trace < debug < info < warn < error < fatal.
	// Anything below the configured level is dropped.
	logger := vlogger.new(vlogger.LoggerCfg{
		write_fn: vlogger.write_json_message_fn(fn (_ IError) {}, mut out)
		message:  vlogger.MessageCfg{
			level: .trace // use `.debug` to keep trace filtered out
		}
	})
	defer { logger.close() }

	logger.trace().bool('hello', false).send()
	logger.debug().u8('number', 8).string('test', 'this is a test').f32('float_val', 3.66).send()
	logger.info().bool('hello', false).message('hello there')
	logger.warn().f64('number', 776.54323).message('another number')

	logger.error().strut('struct', LoggableStrut{
		name: 'John'
		age:  19
	}).send()

	logger.info().array('nodes', [vlogger.Value('hello'), vlogger.Value('there')]).send()

	// a type that renders itself as a scalar, via the Renderable extension point
	logger.info().custom('bind', Ip{[u8(192), 168, 0, 1]}).send()
	logger.fatal().err('error', error('failure')).send()
}
