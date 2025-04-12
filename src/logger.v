module vlogger

import io

// Logger can be seen as a Message factory. The idea is that a Message would carry all the necessary
pub interface Logger {
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
	message_cfg := cfg.message
	if message_cfg.level == MessageLevel.none {
		return NopLogger{}
	}

	mut hook_fns_new := cfg.hook_fns.clone()
	hook_fns_new << append_message_level_fn(message_cfg.level_fieldname)

	timestamp_cfg := cfg.timestamp

	if timestamp_cfg.enabled {
		if timestamp_cfg.format == .custom {
			hook_fns_new << append_custom_timestamp_fn(timestamp_cfg.custom, timestamp_cfg.fieldname)
		} else {
			hook_fns_new << append_timestamp_fn(timestamp_cfg.format, timestamp_cfg.fieldname)
		}
	}

	logger := DefaultLogger{
		message_fieldname: message_cfg.fieldname
		message_chan:      chan Message{cap: int(cfg.buffer_size)}
		level:             message_cfg.level
		write_fn:          cfg.write_fn
		hook_fns:          hook_fns_new
	}

	spawn logger.write_message_task()

	return logger
}
