module vlogger

// MessageLevel orders log levels by severity. `none` deliberately sits above
// `fatal`: used as a logger threshold it lets nothing through, which is what the
// name implies. Use `trace` as the threshold to let everything through.
pub enum MessageLevel as u8 {
	trace
	debug
	info
	warn
	error
	fatal
	none
}

// append_message_level_fn returns a HookFn that adds the message's level as a
// string field stored under level_fieldname.
pub fn append_message_level_fn(level_fieldname string) HookFn {
	return fn [level_fieldname] (msg DefaultMessage) ?DefaultMessage {
		return msg.string(level_fieldname, msg.level.str())
	}
}
