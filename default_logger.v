module vlogger

pub type MessageWriterFn = fn (Loggable)

pub type HookFn = fn (DefaultMessage) ?DefaultMessage

struct DefaultLogger {
	message_fieldname string              @[required]
	message_chan      chan DefaultMessage @[required]
	level             MessageLevel        @[required]
	writer_thr        thread
}

struct WriterTask {
	write_fn     MessageWriterFn     @[required]
	message_chan chan DefaultMessage @[required]
	hook_fns     []HookFn
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

fn (w WriterTask) start() {
	out: for {
		m := <-w.message_chan or { break }

		mut new_msg := m
		for f in w.hook_fns {
			new_msg = f(new_msg) or { continue out }
		}

		w.write_fn(new_msg)
	}
}

fn (l DefaultLogger) create_message(level MessageLevel) DefaultMessage {
	return DefaultMessage{
		level:             level
		message_chan:      l.message_chan
		message_fieldname: l.message_fieldname
	}
}

pub fn (l DefaultLogger) trace() DefaultMessage {
	return l.create_message(MessageLevel.trace)
}

pub fn (l DefaultLogger) debug() DefaultMessage {
	return l.create_message(MessageLevel.debug)
}

pub fn (l DefaultLogger) info() DefaultMessage {
	return l.create_message(MessageLevel.info)
}

pub fn (l DefaultLogger) warn() DefaultMessage {
	return l.create_message(MessageLevel.warn)
}

pub fn (l DefaultLogger) error() DefaultMessage {
	return l.create_message(MessageLevel.error)
}

pub fn (l DefaultLogger) fatal() DefaultMessage {
	return l.create_message(MessageLevel.fatal)
}

pub fn (l DefaultLogger) close() {
	l.message_chan.close()
	l.writer_thr.wait()
}
