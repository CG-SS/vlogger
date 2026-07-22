module vlogger

// The per-type default values that used to live here existed only so that a
// wrongly typed accessor on the old Value interface could return something
// rather than fail. A Value is now a sum type, so reading it as the wrong type
// is a compile error and the defaults have no purpose.

const default_message_fieldname = 'message'

const default_timestamp_fieldname = 'timestamp'

const default_level_fieldname = 'level'

const default_buffer_size = 1024
