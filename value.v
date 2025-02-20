module vlogger

// Value represents a value in the log. The value include all Golang's primitive types, an array of Value, a
// map[Value]Value or a Fieldable.
// The idea is that, when a MessageMarshaller function is parsing a Value, it will know which PrimitiveType it is by
// using Type, and call the appropriate type function, for instance, if the PrimitiveType is StringType, the function
// would call String, in which String would return the proper internal value of Value.
// All the functions are meant to be safe, that is, if you wrongly call one of the value functions, they will return a
// default value, there is no 'panic' or error that is returned. For instance, if you call UInt on a Float32Type, it
// should return defaultIntVal.
interface Value {
	primitive_type() PrimitiveType
	bool() bool
	string() string
	i8() i8
	i16() i16
	int() int
	i64() i64
	u8() u8
	u16() u16
	u32() u32
	u64() u64
	rune() rune
	f32() f32
	f64() f64
	array() []Value
	// TODO: when V supports, change the type to map[Value]Value.
	map() map[string]Value
	strut() Loggable
	error() IError
}