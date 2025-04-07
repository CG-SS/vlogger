module vlogger

import io

// Logger can be seen as a Message factory. The idea is that a Message would carry all the necessary
interface Logger {
	trace() Message
	debug() Message
	info() Message
	warn() Message
	error() Message
	fatal() Message
}

pub fn default(mut out io.Writer) Logger {
	return new(LoggerCfg{
		write_fn: write_json_message_fn(fn (_ IError) {}, mut out)
	})
}

pub fn new(cfg LoggerCfg) Logger {
	if cfg.level == MessageLevel.none {
		return NopLogger{}
	}

	mut hook_fns_new := cfg.hook_fns.clone()
	hook_fns_new << append_timestamp_fn(AppendTimestampCfg{})
	hook_fns_new << append_message_level_fn(default_level_fieldname)

	logger := DefaultLogger{
		message_fieldname: cfg.message_fieldname
		message_chan:      chan Message{cap: cfg.buffer_size}
		level:             cfg.level
		write_fn:          cfg.write_fn
		hook_fns:          hook_fns_new
	}

	spawn logger.write_message_task()

	return logger
}
