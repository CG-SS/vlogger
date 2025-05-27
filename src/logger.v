module vlogger

import io

pub fn default(mut out io.Writer) DefaultLogger {
	return new(LoggerCfg{
		write_fn: write_json_message_fn(fn (_ IError) {}, mut out)
	})
}

pub fn new(cfg LoggerCfg) DefaultLogger {
	message_cfg := cfg.message

	mut hook_fns_new := cfg.hook_fns.clone()
	hook_fns_new << append_message_level_fn(message_cfg.level_fieldname)

	logger_level := message_cfg.level
	hook_fns_new << filter_by_level_fn(logger_level)

	timestamp_cfg := cfg.timestamp

	if timestamp_cfg.enabled {
		if timestamp_cfg.format == .custom {
			hook_fns_new << append_custom_timestamp_fn(timestamp_cfg.custom, timestamp_cfg.fieldname)
		} else {
			hook_fns_new << append_timestamp_fn(timestamp_cfg.format, timestamp_cfg.fieldname)
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
		writer_thr:        spawn writer_task.start()
	}

	return logger
}
