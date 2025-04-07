module vlogger

// MessageLevel of a given Message. It represents a message level in terms of awareness.
enum MessageLevel as u8 {
	none
	trace
	debug
	info
	warn
	error
	fatal
}

fn append_message_level_fn(level_fieldname string) HookFn {
	return fn [level_fieldname] (msg Message) Message {
		return msg.string(level_fieldname, msg.level().str())
	}
}
