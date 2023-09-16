module vlogger

struct DefaultLogger {
	write_channel chan Message
	log_level     Level
}

pub fn (l DefaultLogger) trace() Message {
	return LogMessage{
		message_channel: l.write_channel
		level: .trace
	}
}

pub fn (l DefaultLogger) debug() Message {
	return LogMessage{
		message_channel: l.write_channel
		level: .debug
	}
}

pub fn (l DefaultLogger) info() Message {
	return LogMessage{
		message_channel: l.write_channel
		level: .info
	}
}

pub fn (l DefaultLogger) warn() Message {
	return LogMessage{
		message_channel: l.write_channel
		level: .warn
	}
}

pub fn (l DefaultLogger) error() Message {
	return LogMessage{
		message_channel: l.write_channel
		level: .error
	}
}

pub fn (l DefaultLogger) fatal() Message {
	return LogMessage{
		message_channel: l.write_channel
		level: .fatal
	}
}

pub fn (l DefaultLogger) panic() Message {
	return LogMessage{
		message_channel: l.write_channel
		level: .panic
	}
}
