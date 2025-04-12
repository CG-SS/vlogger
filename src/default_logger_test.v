module vlogger

fn test_default_logger_writes_message() {
	receiver_chan := chan Message{}
	defer { receiver_chan.close() }

	logger := DefaultLogger{
		message_fieldname: 'field_test'
		message_chan:      chan Message{}
		level:             .info
		write_fn:          fn [receiver_chan] (msg Message) {
			receiver_chan <- msg
		}
	}

	spawn logger.write_message_task()

	mut wrote_msgs := []Message{cap: 2}

	logger.info().message('test msg')
	wrote_msgs << <-receiver_chan

	logger.info().message('another msg')
	wrote_msgs << <-receiver_chan

	logger.message_chan.close()

	assert wrote_msgs.len == 2
}

fn test_default_logger_hook_fns() {
	receiver_chan := chan Message{}
	defer { receiver_chan.close() }

	logger := DefaultLogger{
		message_fieldname: 'field_test'
		message_chan:      chan Message{}
		level:             .info
		write_fn:          nop_message_writer
		hook_fns:          [
			fn [receiver_chan] (msg Message) Message {
				receiver_chan <- msg

				return msg
			},
		]
	}

	spawn logger.write_message_task()

	mut wrote_msgs := []Message{cap: 2}

	logger.info().message('hook test')
	wrote_msgs << <-receiver_chan

	logger.info().message('hook test msg')
	wrote_msgs << <-receiver_chan

	logger.message_chan.close()

	assert wrote_msgs.len == 2
}

fn test_default_logger_level() {
	receiver_chan := chan Message{}
	defer { receiver_chan.close() }

	logger := DefaultLogger{
		message_fieldname: 'field_test'
		message_chan:      chan Message{}
		level:             .fatal
		write_fn:          fn [receiver_chan] (msg Message) {
			receiver_chan <- msg
		}
	}

	spawn logger.write_message_task()

	mut wrote_msgs := []Message{cap: 1}

	logger.trace().message('msg')
	logger.debug().message('msg')
	logger.info().message('msg')
	logger.warn().message('msg')
	logger.error().message('msg')
	logger.fatal().message('msg')
	wrote_msgs << <-receiver_chan

	logger.message_chan.close()

	assert wrote_msgs.len == 1
}
