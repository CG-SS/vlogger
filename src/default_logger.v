module vlogger

pub type MessageWriterFn = fn (Loggable)

pub type HookFn = fn (Message) Message

struct DefaultLogger {
	message_fieldname string          @[required]
	message_chan      chan Message    @[required]
	level             MessageLevel    @[required]
	write_fn          MessageWriterFn @[required]
	hook_fns          []HookFn
}

pub struct TimestampCfg {
pub:
	enabled   bool            = true
	fieldname string          = default_timestamp_fieldname
	format    TimestampFormat = .default
	custom    string
}

pub struct MessageCfg {
pub:
	fieldname       string       = default_message_fieldname
	level           MessageLevel = MessageLevel.info
	level_fieldname string       = default_level_fieldname
}

pub struct LoggerCfg {
pub:
	buffer_size i32             = default_buffer_size
	write_fn    MessageWriterFn = nop_message_writer
	hook_fns    []HookFn
	timestamp   TimestampCfg
	message     MessageCfg
}

fn (l DefaultLogger) write_message_task() {
	for {
		m := <-l.message_chan or { break }

		mut new_msg := m
		for f in l.hook_fns {
			new_msg = f(new_msg)
		}

		l.write_fn(new_msg as Loggable)
	}
}

fn (l DefaultLogger) create_message(level MessageLevel) Message {
	if u8(l.level) > u8(level) {
		return NopMessage{}
	}

	return DefaultMessage{
		message_level:     level
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
