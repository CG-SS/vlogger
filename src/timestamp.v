module vlogger

import time

pub enum TimestampFormat {
	default
	rfc3339
	rfc3339_micro
	rfc3339_nano
	ss
	ss_micro
	ss_milli
	ss_nano
	unix
	unix_micro
	unix_milli
	unix_nano
	custom
}

fn append_custom_timestamp_fn(custom_format string, timestamp_field_name string) HookFn {
	return fn [timestamp_field_name, custom_format] (msg DefaultMessage) ?DefaultMessage {
		now := time.now()

		return msg.string(timestamp_field_name, now.custom_format(custom_format))
	}
}

fn append_timestamp_fn(format TimestampFormat, timestamp_field_name string) HookFn {
	return fn [format, timestamp_field_name] (msg DefaultMessage) ?DefaultMessage {
		now := time.now()

		match format {
			.default {
				return msg.string(timestamp_field_name, now.format())
			}
			.rfc3339 {
				return msg.string(timestamp_field_name, now.format_rfc3339())
			}
			.rfc3339_micro {
				return msg.string(timestamp_field_name, now.format_rfc3339_micro())
			}
			.rfc3339_nano {
				return msg.string(timestamp_field_name, now.format_rfc3339_nano())
			}
			.ss {
				return msg.string(timestamp_field_name, now.format_ss())
			}
			.ss_micro {
				return msg.string(timestamp_field_name, now.format_ss_micro())
			}
			.ss_milli {
				return msg.string(timestamp_field_name, now.format_ss_milli())
			}
			.ss_nano {
				return msg.string(timestamp_field_name, now.format_ss_nano())
			}
			.unix {
				return msg.i64(timestamp_field_name, now.unix())
			}
			.unix_micro {
				return msg.i64(timestamp_field_name, now.unix_micro())
			}
			.unix_milli {
				return msg.i64(timestamp_field_name, now.unix_milli())
			}
			.unix_nano {
				return msg.i64(timestamp_field_name, now.unix_nano())
			}
			else {
				return msg
			}
		}
	}
}
