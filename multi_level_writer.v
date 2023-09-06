module vlogger

import io

pub struct MultiLevelWriter {
	trace_level_error_handler fn (IError)
	debug_level_error_handler fn (IError)
	info_level_error_handler  fn (IError)
	warn_level_error_handler  fn (IError)
	error_level_error_handler fn (IError)
mut:
	trace_writer io.MultiWriter
	debug_writer io.MultiWriter
	info_writer  io.MultiWriter
	warn_writer  io.MultiWriter
	error_writer io.MultiWriter
}

fn (mut m MultiLevelWriter) write_level_message(event_message EventMessage) {
	mut buffer_bytes := event_message.payload

	match event_message.level {
		.trace { m.trace_writer.write(buffer_bytes) or { m.trace_level_error_handler(err) } }
		.debug { m.debug_writer.write(buffer_bytes) or { m.debug_level_error_handler(err) } }
		.info { m.info_writer.write(buffer_bytes) or { m.info_level_error_handler(err) } }
		.warn { m.warn_writer.write(buffer_bytes) or { m.warn_level_error_handler(err) } }
		.error { m.error_writer.write(buffer_bytes) or { m.error_level_error_handler(err) } }
		.fatal {}
		.panic {}
	}
}
