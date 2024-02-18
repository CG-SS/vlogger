module vlogger

// Logger can be seen as a Message factory. The idea is that a Message would carry all the necessary 
interface Logger {
	trace() Message
	debug() Message
	info() Message
	warn() Message
	error() Message
	fatal() Message
	panic() Message
}