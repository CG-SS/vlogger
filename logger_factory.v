module vlogger

import json
import strings

type HookFunc = fn (Message) ?Message

type MessageMarshallerFn = fn (Message) ?[]u8

fn json_marshaller(message Message) ?[]u8 {
	if message.fields.len == 0 {
		return none
	}

	mut builder := strings.new_builder(0)
	builder.write_string('{')

	for field in message.fields {
		if field is BoolField {
			builder.write_string('${json.encode(field.key)}:"${field.get_bool()}"')
		}
	}

	builder.write_string('}')

	return builder
}

struct LoggerFactory {
	buffer_size    int   = 1024
	log_level      Level = .debug
	hook_functions []HookFunc
	marshaller     MessageMarshallerFn = json_marshaller
}

pub fn new_logger() LoggerFactory {
	return LoggerFactory{}
}

pub fn (lf LoggerFactory) with_hook_functions(hook_function HookFunc) LoggerFactory {
	mut new_hook_functions := lf.hook_functions.clone()
	new_hook_functions << hook_function

	return LoggerFactory{
		buffer_size: lf.buffer_size
		log_level: lf.log_level
		hook_functions: new_hook_functions
	}
}

pub fn (lf LoggerFactory) with_buffer_size(new_buffer_size int) LoggerFactory {
	return LoggerFactory{
		buffer_size: new_buffer_size
		log_level: lf.log_level
		hook_functions: lf.hook_functions
	}
}

pub fn (lf LoggerFactory) with_log_level(new_log_level Level) LoggerFactory {
	return LoggerFactory{
		buffer_size: lf.buffer_size
		log_level: new_log_level
		hook_functions: lf.hook_functions
	}
}

pub fn (lf LoggerFactory) logger(mut level_writer LevelWriter) DefaultLogger {
	write_channel := chan Message{cap: lf.buffer_size}

	spawn handle_writer(write_channel, lf.hook_functions, mut level_writer)

	return DefaultLogger{
		write_channel: write_channel
		log_level: lf.log_level
	}
}

fn handle_writer(write_channel chan Message, hook_functions []HookFunc, mut level_writer LevelWriter) {
	out: for {
		mut message := <-write_channel or { break }

		for f in hook_functions {
			message = f(message) or { continue out }
		}

		payload := json_marshaller(message) or { continue }

		level_writer.write_level(message.level, payload)
	}
}
