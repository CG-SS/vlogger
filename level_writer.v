module vlogger

import io

interface LevelWriter {
mut:
	write_level(level Level, payload []u8)
}

pub struct SingleLevelWriter {
	error_handler fn (IError) [required]
mut:
	writer io.Writer
}

fn (mut s SingleLevelWriter) write_level(level Level, payload []u8) {
	s.writer.write(payload) or { s.error_handler(err) }
}
