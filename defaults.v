module vlogger

// default_bool_val is the default value used for Bool when the PrimitiveType is not BoolType.
const default_bool_val = false
// default_string_val is the default string value used for String when the PrimitiveType is not StringType.
const default_string_val = ''
// default_int_val is the default string value used for all the Int types when their corresponding PrimitiveType
// are not correct.
const default_int_val = 0
// default_float_val is the default float value used for all the Float types when their corresponding PrimitiveType
// are not correct.
const default_float_val = 0.0

const default_error = error('default error')

struct DefaultLoggable {
}

fn (_ DefaultLoggable) fields() []Field {
	return []
}

const default_loggable_val = DefaultLoggable{}

const default_message_fieldname = 'message'

const default_timestamp_fieldname = 'timestamp'

const default_level_fieldname = 'level'

const default_buffer_size = 1024

const default_map_val = map[string]Value{}

const default_array_val = []Value{}
