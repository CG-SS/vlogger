module vlogger

import time

// --- level filtering must happen at the call site, not in the writer thread ---

fn test_messages_below_the_logger_level_never_reach_the_channel() {
	ch := chan DefaultMessage{cap: 16}
	logger := DefaultLogger{
		message_fieldname: 'msg'
		message_chan:      ch
		level:             .warn
	}

	logger.trace().string('k', 'v').send()
	logger.debug().string('k', 'v').send()
	logger.info().string('k', 'v').send()

	// discarded messages must cost nothing: no allocation, no channel traffic
	assert ch.len == 0

	logger.warn().string('k', 'v').send()
	logger.error().string('k', 'v').send()
	assert ch.len == 2
}

fn test_discarded_messages_ignore_builders_and_message() {
	ch := chan DefaultMessage{cap: 16}
	logger := DefaultLogger{
		message_fieldname: 'msg'
		message_chan:      ch
		level:             .error
	}

	logger.info().string('a', '1').bool('b', true).message('dropped')
	logger.debug().array('c', [Value(i32(1))]).send()

	assert ch.len == 0
}

fn test_enabled_messages_still_carry_their_fields() {
	ch := chan DefaultMessage{cap: 4}
	logger := DefaultLogger{
		message_fieldname: 'msg'
		message_chan:      ch
		level:             .info
	}

	logger.warn().string('a', '1').send()

	got := <-ch
	assert got.level == .warn
	assert got.fields().len == 1
	assert got.fields()[0].key == 'a'
}

// --- timestamps must record when the event happened, not when it was written ---

fn test_timestamp_is_attached_when_the_message_is_created() {
	ch := chan DefaultMessage{cap: 1}
	logger := DefaultLogger{
		message_fieldname: 'msg'
		message_chan:      ch
		level:             .info
		timestamp_fn:      append_timestamp_fn(.ss, 'ts')
	}

	m := logger.info()
	// present immediately, before anything is sent or written
	assert m.fields().len == 1
	assert m.fields()[0].key == 'ts'
	assert (m.fields()[0].value as string).len > 0
}

fn test_timestamp_reflects_creation_time_not_send_time() {
	ch := chan DefaultMessage{cap: 1}
	logger := DefaultLogger{
		message_fieldname: 'msg'
		message_chan:      ch
		level:             .info
		timestamp_fn:      append_timestamp_fn(.unix_milli, 'ts')
	}

	before := time.now().unix_milli()
	m := logger.info()
	time.sleep(60 * time.millisecond)
	m.send()
	after := time.now().unix_milli()

	got := <-ch
	stamped := got.fields()[0].value as i64

	assert stamped >= before
	// clearly nearer creation than the (much later) send
	assert stamped < after - 30
}

fn test_no_timestamp_field_when_disabled() {
	ch := chan DefaultMessage{cap: 1}
	logger := DefaultLogger{
		message_fieldname: 'msg'
		message_chan:      ch
		level:             .info
	}

	m := logger.info()
	assert m.fields().len == 0
}

// --- close() must be safe to call more than once ---

fn test_close_is_idempotent() {
	logger := new(LoggerCfg{
		write_fn: nop_message_writer
	})

	logger.close()
	logger.close()
	logger.close()

	assert true // reaching here without panicking is the assertion
}

fn test_logging_after_close_does_not_panic() {
	logger := new(LoggerCfg{
		write_fn: nop_message_writer
	})
	logger.close()

	logger.info().string('k', 'v').send()
	logger.info().message('after close')

	assert true
}
