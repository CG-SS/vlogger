module vlogger

type ErrorHandlerFn = fn (IError)

// Message represents a Logger message. The intention is that whoever implements the Message interface would use a
// factory pattern in order to build a Message.
pub interface Message {
	Loggable
	level() MessageLevel
	bool(key string, value bool) Message
	string(key string, value string) Message
	i8(key string, value i8) Message
	i16(key string, value i16) Message
	i32(key string, value i32) Message
	i64(key string, value i64) Message
	u8(key string, value u8) Message
	u16(key string, value u16) Message
	u32(key string, value u32) Message
	u64(key string, value u64) Message
	rune(key string, value rune) Message
	f32(key string, value f32) Message
	f64(key string, value f64) Message
	array(key string, value []Value) Message
	map(key string, value map[string]Value) Message
	strut(key string, value Loggable) Message
	err(key string, value IError) Message
	send() Message
	try_send(error_handler ErrorHandlerFn) Message
	message(msg string) Message
}
