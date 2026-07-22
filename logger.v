module vlogger

import io

// default returns a DefaultLogger that writes JSON encoded messages to out.
// It applies the library defaults: an `.info` message level, timestamps enabled
// and write errors silently discarded. Use `new` to override any of those.
pub fn default(mut out io.Writer) DefaultLogger {
	return new(LoggerCfg{
		write_fn: write_json_message_fn(fn (_ IError) {}, mut out)
	})
}

// new returns a DefaultLogger built from cfg and starts the background writer
// thread that drains the message channel. The returned logger must be closed
// with `close`, otherwise buffered messages may be lost.
pub fn new(cfg LoggerCfg) DefaultLogger {
	message_cfg := cfg.message

	mut hook_fns_new := cfg.hook_fns.clone()
	hook_fns_new << append_message_level_fn(message_cfg.level_fieldname)

	logger_level := message_cfg.level
	hook_fns_new << filter_by_level_fn(logger_level)

	timestamp_cfg := cfg.timestamp

	// The timestamp is applied when a message is created, not by the writer
	// thread, so it records when the event happened rather than when the sink
	// got round to it.
	mut timestamp_fn := HookFn(passthrough_hook_fn)

	if timestamp_cfg.enabled {
		if timestamp_cfg.format == .custom {
			timestamp_fn = append_custom_timestamp_fn(timestamp_cfg.custom, timestamp_cfg.fieldname)
		} else {
			timestamp_fn = append_timestamp_fn(timestamp_cfg.format, timestamp_cfg.fieldname)
		}
	}

	message_chan := chan DefaultMessage{cap: int(cfg.buffer_size)}

	writer_task := WriterTask{
		write_fn:     cfg.write_fn
		hook_fns:     hook_fns_new
		message_chan: message_chan
	}

	logger := DefaultLogger{
		message_fieldname: message_cfg.fieldname
		message_chan:      message_chan
		level:             logger_level
		timestamp_fn:      timestamp_fn
		writer_thr:        spawn writer_task.start()
	}

	return logger
}
