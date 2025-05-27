module vlogger

fn test_default_logger_writes_message() {
	receiver_chan := chan DefaultMessage{cap: 1}
	defer { receiver_chan.close() }

	logger := DefaultLogger{
		message_fieldname: 'field_test'
		message_chan:      receiver_chan
		level:             .info
	}

	mut wrote_msgs := []DefaultMessage{cap: 2}

	logger.info().message('test msg')
	wrote_msgs << <-receiver_chan

	logger.info().message('another msg')
	wrote_msgs << <-receiver_chan

	assert wrote_msgs.len == 2
}
