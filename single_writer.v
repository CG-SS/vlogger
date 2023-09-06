module vlogger

import io

pub struct SingleWriter {
	error_handler fn (IError)
mut:
	writer io.Writer
}

fn (mut m SingleWriter) write_level_message(event_message EventMessage) {
	m.writer.write(event_message.payload) or { m.error_handler(err) }
}
