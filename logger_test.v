module vlogger

import json2

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

	output := json2.decode[TestDefaultLoggerOutput](mem_writer.buffer.bytestr()) or {
		assert false, 'json.decode failed: ${err}'
		return
	}

	assert output.message == 'test'
	assert output.level == 'info'
	assert output.timestamp.len > 0
}

// `.none` sits above every real level, so as a threshold it lets nothing
// through. `.trace` is the threshold that lets everything through.
//
// An earlier version of this test captured a bare struct writer in the closure.
// Closures copy such a capture, so the assertion inspected a writer the logger
// never touched and would have passed whatever the level did. The counter below
// is an array, whose buffer is shared with the copy, so writes are observed.
fn test_new_logger_none_level_suppresses_everything() {
	mut writes := []int{len: 1}

	logger := new(LoggerCfg{
		write_fn: fn [mut writes] (_ Loggable) {
			writes[0]++
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

	assert writes[0] == 0
}

fn test_new_logger_trace_level_lets_every_level_through() {
	mut writes := []int{len: 1}

	logger := new(LoggerCfg{
		write_fn: fn [mut writes] (_ Loggable) {
			writes[0]++
		}
		message:  MessageCfg{
			level: .trace
		}
	})
	logger.trace().message('test')
	logger.debug().message('test')
	logger.info().message('test')
	logger.warn().message('test')
	logger.error().message('test')
	logger.fatal().message('test')
	logger.close()

	assert writes[0] == 6
}

fn test_new_logger_suppresses_levels_below_the_threshold() {
	mut writes := []int{len: 1}

	logger := new(LoggerCfg{
		write_fn: fn [mut writes] (_ Loggable) {
			writes[0]++
		}
		message:  MessageCfg{
			level: .error
		}
	})
	logger.trace().message('test')
	logger.debug().message('test')
	logger.info().message('test')
	logger.warn().message('test')
	logger.error().message('test')
	logger.fatal().message('test')
	logger.close()

	assert writes[0] == 2
}
