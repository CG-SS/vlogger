module vlogger

import json

/*
* Event represents an event message.
*/
struct Event {
	write_chan chan EventMessage
	buffer     string
	level      Level
}

pub fn (e Event) kv[T](key string, value T) Event {
	kv_pair_val := '${json.encode(key)}:${json.encode(value)}'

	return Event{
		write_chan: e.write_chan
		buffer: if e.buffer.len == 0 { kv_pair_val } else { '${e.buffer},${kv_pair_val}' }
		level: e.level
	}
}

pub fn (e Event) level(new_level Level) Event {
	return Event{
		write_chan: e.write_chan
		buffer: e.buffer
		level: new_level
	}
}

pub fn (e Event) send() {
	e.write_chan.try_push(EventMessage{
		level: e.level
		payload: '{${e.buffer}}\n'.bytes()
	})
}
