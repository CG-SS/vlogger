module vlogger

// Field represents a field on a log message.
// The concept is that a field in whatever log structure will be a key value pair, where the key is a string, much
// similar to JSON.
struct Field {
	key   string
	value Value
}

