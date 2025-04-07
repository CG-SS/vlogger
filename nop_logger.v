module vlogger

struct NopLogger {
}

fn (_ NopLogger) trace() Message {
	return NopMessage{}
}

fn (_ NopLogger) debug() Message {
	return NopMessage{}
}

fn (_ NopLogger) info() Message {
	return NopMessage{}
}

fn (_ NopLogger) warn() Message {
	return NopMessage{}
}

fn (_ NopLogger) error() Message {
	return NopMessage{}
}

fn (_ NopLogger) fatal() Message {
	return NopMessage{}
}
