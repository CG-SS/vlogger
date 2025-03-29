module vlogger

struct DefaultLogger {
	message_fieldname string       = default_message_fieldname
	message_chan      chan Message = chan Message{cap: 1024}
	message_level     MessageLevel = MessageLevel.info
}

pub fn DefaultLogger.new() Logger {
	default_logger := DefaultLogger{}

	spawn write_message(default_logger.message_chan)

	return default_logger
}

fn write_message(message_chan chan Message) {
	for {
		m := <-message_chan or { break }
		println(m)
	}
}

fn (l DefaultLogger) create_message(message_level MessageLevel) Message {
	if u8(l.message_level) > u8(message_level) {
		return NopMessage{}
	}

	return DefaultMessage{
		message_level:     message_level
		message_chan:      l.message_chan
		message_fieldname: l.message_fieldname
	}
}

fn (l DefaultLogger) trace() Message {
	return l.create_message(MessageLevel.trace)
}

fn (l DefaultLogger) debug() Message {
	return l.create_message(MessageLevel.debug)
}

fn (l DefaultLogger) info() Message {
	return l.create_message(MessageLevel.info)
}

fn (l DefaultLogger) warn() Message {
	return l.create_message(MessageLevel.warn)
}

fn (l DefaultLogger) error() Message {
	return l.create_message(MessageLevel.error)
}

fn (l DefaultLogger) fatal() Message {
	return l.create_message(MessageLevel.fatal)
}

fn (l DefaultLogger) panic() Message {
	return l.create_message(MessageLevel.panic)
}
