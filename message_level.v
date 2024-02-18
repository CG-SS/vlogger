module vlogger

// MessageLevel of a given Message. It represents a message level in terms of awareness.
enum MessageLevel as u8 {
	trace 
	debug
	info
	warn
	error
	fatal
	panic
}