module vlogger

// Nested carries a Loggable so it can appear inside a Value.
//
// V rejects an interface as a sum type variant ("sum type cannot hold an
// interface"), but a struct may hold one, so each interface travels inside a
// one field wrapper. This keeps the extension point open: any type that
// implements Loggable can be logged as a nested object.
pub struct Nested {
pub:
	inner Loggable
}

// Err carries an IError, wrapped for the same reason as Nested.
pub struct Err {
pub:
	inner IError
}

// Renderable is the extension point for a type that wants to be logged as a
// scalar which it formats itself, rather than as a nested object.
pub interface Renderable {
	render() string
}

// Custom carries a Renderable, wrapped for the same reason as Nested.
pub struct Custom {
pub:
	inner Renderable
}

// Value is everything a log field can hold.
//
// Being a sum type rather than an interface means the tag and the payload are
// the same thing, so a writer cannot read a value as the wrong type and get a
// silent default back. A `match` over a Value is checked for exhaustiveness, so
// adding a variant turns every writer that has not handled it into a compile
// error instead of a runtime surprise.
pub type Value = Custom
	| Err
	| Nested
	| []Value
	| bool
	| f32
	| f64
	| i16
	| i32
	| i64
	| i8
	| map[string]Value
	| rune
	| string
	| u16
	| u32
	| u64
	| u8
