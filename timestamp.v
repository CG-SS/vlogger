module vlogger

import time

enum TimestampType {
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

struct AppendTimestampCfg {
	timestamp_field_name string        = default_timestamp_fieldname
	timestamp_type       TimestampType = .default
	custom_format        string
}

fn append_timestamp_fn(cfg AppendTimestampCfg) HookFn {
	return fn [cfg] (m Message) Message {
		now := time.now()

		match cfg.timestamp_type {
			.default {
				return m.string(cfg.timestamp_field_name, now.format())
			}
			.rfc3339 {
				return m.string(cfg.timestamp_field_name, now.format_rfc3339())
			}
			.rfc3339_micro {
				return m.string(cfg.timestamp_field_name, now.format_rfc3339_micro())
			}
			.rfc3339_nano {
				return m.string(cfg.timestamp_field_name, now.format_rfc3339_nano())
			}
			.ss {
				return m.string(cfg.timestamp_field_name, now.format_ss())
			}
			.ss_micro {
				return m.string(cfg.timestamp_field_name, now.format_ss_micro())
			}
			.ss_milli {
				return m.string(cfg.timestamp_field_name, now.format_ss_milli())
			}
			.ss_nano {
				return m.string(cfg.timestamp_field_name, now.format_ss_nano())
			}
			.unix {
				return m.i64(cfg.timestamp_field_name, now.unix())
			}
			.unix_micro {
				return m.i64(cfg.timestamp_field_name, now.unix_micro())
			}
			.unix_milli {
				return m.i64(cfg.timestamp_field_name, now.unix_milli())
			}
			.unix_nano {
				return m.i64(cfg.timestamp_field_name, now.unix_nano())
			}
			.custom {
				return m.string(cfg.timestamp_field_name, now.custom_format(cfg.custom_format))
			}
		}
	}
}
