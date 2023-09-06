module vlogger

struct Logger {
	write_chan chan EventMessage
	log_level  Level
}

pub fn (l Logger) trace() Event {
	return Event{
		write_chan: l.write_chan
		level: .trace
	}
}

pub fn (l Logger) debug() Event {
	return Event{
		write_chan: l.write_chan
		level: .debug
	}
}

pub fn (l Logger) info() Event {
	return Event{
		write_chan: l.write_chan
		level: .info
	}
}

pub fn (l Logger) warn() Event {
	return Event{
		write_chan: l.write_chan
		level: .warn
	}
}

pub fn (l Logger) error() Event {
	return Event{
		write_chan: l.write_chan
		level: .error
	}
}

pub fn (l Logger) fatal() Event {
	return Event{
		write_chan: l.write_chan
		level: .fatal
	}
}

pub fn (l Logger) panic() Event {
	return Event{
		write_chan: l.write_chan
		level: .panic
	}
}
