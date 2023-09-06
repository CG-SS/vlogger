module vlogger

struct EventMessage {
	level   Level
	payload []u8
}

interface EventMessageWriter {
mut:
	write_level_message(EventMessage)
}
