module vlogger

// The chaining API in default_message.v had no test file at all, which is how
// the `message()` field loss below went unnoticed.

struct TestUser {
	name string
}

fn (u TestUser) fields() []Field {
	return [Field{
		key:   'name'
		value: u.name
	}]
}

struct TestIp {
	octets []u8
}

fn (i TestIp) render() string {
	return i.octets.map(it.str()).join('.')
}

fn new_test_message(ch chan DefaultMessage) DefaultMessage {
	return DefaultMessage{
		message_fieldname: 'msg'
		message_chan:      ch
		level:             .info
	}
}

// --- every builder appends exactly one field, carrying the right value ---

// A Value now carries its payload at its real type, so a test reads it back by
// casting to that type. Casting to the wrong one is a compile error rather than
// a silently defaulted value, which is the point of the sum type.

fn test_bool_appends_field() {
	m := DefaultMessage{}.bool('k', true)
	assert m.fields().len == 1
	assert m.fields()[0].key == 'k'
	assert m.fields()[0].value as bool == true
}

fn test_string_appends_field() {
	m := DefaultMessage{}.string('k', 'v')
	assert m.fields()[0].value as string == 'v'
}

fn test_integer_builders_append_fields() {
	assert DefaultMessage{}.i8('k', -8).fields()[0].value as i8 == -8
	assert DefaultMessage{}.i16('k', -16).fields()[0].value as i16 == -16
	assert DefaultMessage{}.i32('k', -32).fields()[0].value as i32 == -32
	assert DefaultMessage{}.i64('k', -64).fields()[0].value as i64 == -64
	assert DefaultMessage{}.u8('k', 8).fields()[0].value as u8 == 8
	assert DefaultMessage{}.u16('k', 16).fields()[0].value as u16 == 16
	assert DefaultMessage{}.u32('k', 32).fields()[0].value as u32 == 32
	assert DefaultMessage{}.u64('k', 64).fields()[0].value as u64 == 64
}

fn test_float_and_rune_builders_append_fields() {
	assert DefaultMessage{}.f32('k', 1.5).fields()[0].value as f32 == 1.5
	assert DefaultMessage{}.f64('k', 2.5).fields()[0].value as f64 == 2.5
	assert DefaultMessage{}.rune('k', `Z`).fields()[0].value as rune == `Z`
}

fn test_err_builder_appends_field() {
	m := DefaultMessage{}.err('k', error('boom'))
	assert (m.fields()[0].value as Err).inner.msg() == 'boom'
}

fn test_strut_builder_wraps_a_loggable() {
	m := DefaultMessage{}.strut('k', TestUser{'John'})
	assert (m.fields()[0].value as Nested).inner.fields().len == 1
}

fn test_custom_builder_wraps_a_renderable() {
	m := DefaultMessage{}.custom('k', TestIp{[u8(10), 0, 0, 1]})
	assert (m.fields()[0].value as Custom).inner.render() == '10.0.0.1'
}

fn test_array_and_map_builders_append_fields() {
	arr := DefaultMessage{}.array('k', [Value(i32(1)), Value(i32(2))])
	assert (arr.fields()[0].value as []Value).len == 2

	m := DefaultMessage{}.map('k', {
		'a': Value(i32(1))
	})
	assert (m.fields()[0].value as map[string]Value).len == 1
}

// --- chaining accumulates, and never mutates the receiver ---

fn test_chaining_accumulates_all_fields_in_order() {
	m := DefaultMessage{}.string('a', '1').bool('b', true).i32('c', 3)
	assert m.fields().len == 3
	assert m.fields()[0].key == 'a'
	assert m.fields()[1].key == 'b'
	assert m.fields()[2].key == 'c'
}

fn test_builders_do_not_mutate_the_receiver() {
	base := DefaultMessage{}.string('a', '1')
	branch_one := base.string('b', '2')
	branch_two := base.string('c', '3')

	assert base.fields().len == 1
	assert branch_one.fields().len == 2
	assert branch_two.fields().len == 2
	assert branch_one.fields()[1].key == 'b'
	assert branch_two.fields()[1].key == 'c'
}

// --- send ---

fn test_send_pushes_the_message_onto_the_channel() {
	ch := chan DefaultMessage{cap: 1}
	new_test_message(ch).string('k', 'v').send()

	got := <-ch
	assert got.fields().len == 1
	assert got.fields()[0].key == 'k'
	assert got.level == .info
}

fn test_try_send_reports_failure_when_the_buffer_is_full() {
	ch := chan DefaultMessage{cap: 1}
	// a fixed slot, because a closure that appends to a captured array only
	// grows its own copy
	mut failures := []int{len: 1}

	new_test_message(ch).string('a', '1').try_send(fn [mut failures] (_ IError) {
		failures[0]++
	})
	// buffer now full, so the second attempt must invoke the error handler
	new_test_message(ch).string('b', '2').try_send(fn [mut failures] (_ IError) {
		failures[0]++
	})

	assert ch.len == 1
	assert failures[0] == 1
}

// --- message() ---

fn test_message_includes_previously_added_fields() {
	ch := chan DefaultMessage{cap: 4}
	new_test_message(ch).string('a', '1').bool('b', false).message('hello')

	got := <-ch
	assert got.fields().len == 3
	assert got.fields()[2].key == 'msg'
	assert got.fields()[2].value as string == 'hello'
}

fn test_message_sends_exactly_one_record() {
	ch := chan DefaultMessage{cap: 8}
	new_test_message(ch).string('a', '1').message('hello')

	// `message()` is terminal. It must not leave a second, message-less record
	// behind, which is what happened while it returned a stale receiver.
	assert ch.len == 1
}

fn test_message_uses_the_configured_fieldname() {
	ch := chan DefaultMessage{cap: 1}
	m := DefaultMessage{
		message_fieldname: 'custom_msg'
		message_chan:      ch
		level:             .warn
	}
	m.message('hi')

	got := <-ch
	assert got.fields()[0].key == 'custom_msg'
}
