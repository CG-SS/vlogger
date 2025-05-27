module vlogger

struct NopLogger {
}

fn (_ NopLogger) trace() NopMessage {
	return NopMessage{}
}

fn (_ NopLogger) debug() NopMessage {
	return NopMessage{}
}

fn (_ NopLogger) info() NopMessage {
	return NopMessage{}
}

fn (_ NopLogger) warn() NopMessage {
	return NopMessage{}
}

fn (_ NopLogger) error() NopMessage {
	return NopMessage{}
}

fn (_ NopLogger) fatal() NopMessage {
	return NopMessage{}
}

fn (_ NopLogger) close() {
}
