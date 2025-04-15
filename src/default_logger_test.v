module vlogger

fn test_default_logger_writes_message() {
	receiver_chan := chan Message{cap: 1}
	defer { receiver_chan.close() }

	logger := DefaultLogger{
		message_fieldname: 'field_test'
		message_chan:      receiver_chan
		level:             .info
	}

	mut wrote_msgs := []Message{cap: 2}

	logger.info().message('test msg')
	wrote_msgs << <-receiver_chan

	logger.info().message('another msg')
	wrote_msgs << <-receiver_chan

	assert wrote_msgs.len == 2
}

fn test_default_logger_level() {
	receiver_chan := chan Message{cap: 1}
	defer { receiver_chan.close() }

	logger := DefaultLogger{
		message_fieldname: 'field_test'
		message_chan:      receiver_chan
		level:             .fatal
	}

	mut wrote_msgs := []Message{cap: 1}

	logger.trace().message('msg')
	logger.debug().message('msg')
	logger.info().message('msg')
	logger.warn().message('msg')
	logger.error().message('msg')
	logger.fatal().message('msg')
	wrote_msgs << <-receiver_chan

	assert wrote_msgs.len == 1
}
