module vlogger

pub type MessageWriterFn = fn (Loggable)

pub type HookFn = fn (DefaultMessage) ?DefaultMessage

struct DefaultLogger {
	message_fieldname string              @[required]
	message_chan      chan DefaultMessage @[required]
	level             MessageLevel        @[required]
	// timestamp_fn stamps a message as it is created, rather than as it is
	// written, so the recorded time is when the event happened. Defaults to a
	// passthrough, which is what a logger configured without timestamps gets.
	timestamp_fn HookFn = passthrough_hook_fn
	writer_thr   thread
}

// passthrough_hook_fn returns the message unchanged.
fn passthrough_hook_fn(msg DefaultMessage) ?DefaultMessage {
	return msg
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
	// Filtering happens here rather than in a writer hook. A message below the
	// logger's level is never built, never allocated and never queued, which is
	// what makes a disabled level cheap.
	if u8(level) < u8(l.level) {
		return DefaultMessage{
			level:   level
			discard: true
		}
	}

	msg := DefaultMessage{
		level:             level
		message_chan:      l.message_chan
		message_fieldname: l.message_fieldname
	}

	return l.timestamp_fn(msg) or { msg }
}

// trace starts a new message at the `.trace` level.
pub fn (l DefaultLogger) trace() DefaultMessage {
	return l.create_message(MessageLevel.trace)
}

// debug starts a new message at the `.debug` level.
pub fn (l DefaultLogger) debug() DefaultMessage {
	return l.create_message(MessageLevel.debug)
}

// info starts a new message at the `.info` level.
pub fn (l DefaultLogger) info() DefaultMessage {
	return l.create_message(MessageLevel.info)
}

// warn starts a new message at the `.warn` level.
pub fn (l DefaultLogger) warn() DefaultMessage {
	return l.create_message(MessageLevel.warn)
}

// error starts a new message at the `.error` level.
pub fn (l DefaultLogger) error() DefaultMessage {
	return l.create_message(MessageLevel.error)
}

// fatal starts a new message at the `.fatal` level. It only logs; it does not
// terminate the program.
pub fn (l DefaultLogger) fatal() DefaultMessage {
	return l.create_message(MessageLevel.fatal)
}

// close closes the message channel and waits for the background writer thread
// to drain it, so messages already sent are flushed before it returns.
//
// Calling close more than once is safe and does nothing after the first call.
// Without that guard the second call joins an already joined thread, which
// aborts the process.
pub fn (l DefaultLogger) close() {
	if l.message_chan.closed {
		return
	}

	l.message_chan.close()
	l.writer_thr.wait()
}
