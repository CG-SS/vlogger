module vlogger

fn filter_by_level_fn(logger_level MessageLevel) HookFn {
	return fn [logger_level] (msg DefaultMessage) ?DefaultMessage {
		if u8(msg.level) >= u8(logger_level) {
			return msg
		}
		return none
	}
}
