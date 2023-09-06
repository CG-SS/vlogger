module vlogger

struct LoggerFactory {
	buffer_size int   = 1024
	log_level   Level = .debug
}

pub fn new_logger() LoggerFactory {
	return LoggerFactory{}
}

pub fn (lf LoggerFactory) with_buffer_size(new_buffer_size int) LoggerFactory {
	return LoggerFactory{
		buffer_size: new_buffer_size
		log_level: lf.log_level
	}
}

pub fn (lf LoggerFactory) with_log_level(new_log_level Level) LoggerFactory {
	return LoggerFactory{
		buffer_size: lf.buffer_size
		log_level: new_log_level
	}
}

pub fn (lf LoggerFactory) logger(mut event_message_writer EventMessageWriter) Logger {
	write_chan := chan EventMessage{cap: lf.buffer_size}

	spawn handle_writer(write_chan, mut event_message_writer)

	return Logger{
		write_chan: write_chan
		log_level: lf.log_level
	}
}

fn handle_writer(write_chan chan EventMessage, mut event_message_writer EventMessageWriter) {
	for {
		event_message := <-write_chan or { break }

		event_message_writer.write_level_message(event_message)
	}
}
