module vlogger

import json

struct MemWriter {
pub mut:
	buffer []u8
}

fn (mut m MemWriter) write(buf []u8) !int {
	m.buffer << buf

	return buf.len
}

struct TestDefaultLoggerOutput {
	message   string
	timestamp string
	level     string
}

fn test_default_logger() {
	mut mem_writer := MemWriter{}

	logger := default(mut mem_writer)

	logger.info().message('test')
	logger.close()

	assert mem_writer.buffer.len > 0

	output := json.decode(TestDefaultLoggerOutput, mem_writer.buffer.bytestr()) or {
		assert false, 'json.decode failed: ${err}'
		return
	}

	assert output.message == 'test'
	assert output.level == 'info'
	assert output.timestamp.len > 0
}

fn test_new_logger_nop() {
	mut mem_writer := MemWriter{}

	logger := new(LoggerCfg{
		write_fn: fn [mut mem_writer] (_ Loggable) {
			mem_writer.write('message'.bytes()) or {}
		}
		message:  MessageCfg{
			level: .none
		}
	})
	logger.trace().message('test')
	logger.debug().message('test')
	logger.info().message('test')
	logger.warn().message('test')
	logger.error().message('test')
	logger.fatal().message('test')
	logger.close()

	assert mem_writer.buffer.len == 0
}
