module vlogger

import json2

struct EscFields {
	ar []Field
}

fn (e EscFields) fields() []Field {
	return e.ar
}

// --- string escaping ---

fn test_json_escapes_double_quote() {
	assert value_to_json_str('he said "hi"') == '"he said \\"hi\\""'
}

fn test_json_escapes_backslash() {
	assert value_to_json_str('C:\\path') == '"C:\\\\path"'
}

fn test_json_escapes_newline() {
	assert value_to_json_str('line1\nline2') == '"line1\\nline2"'
}

fn test_json_escapes_carriage_return_and_tab() {
	assert value_to_json_str('a\rb\tc') == '"a\\rb\\tc"'
}

fn test_json_escapes_control_char_as_unicode() {
	assert value_to_json_str('a\x01b') == '"a\\u0001b"'
}

fn test_json_leaves_plain_string_untouched() {
	assert value_to_json_str('plain text') == '"plain text"'
}

// --- errors are strings too, so they need the same treatment ---

fn test_json_escapes_error_message() {
	assert value_to_json_str(Err{error('bad "input"')}) == '"bad \\"input\\""'
}

// --- keys need escaping as well ---

fn test_json_escapes_field_key() {
	out := loggable_to_json_str(EscFields{
		ar: [Field{
			key:   'a"b'
			value: i32(1)
		}]
	})
	assert out == '{"a\\"b":1}'
}

fn test_json_escapes_map_key() {
	m := {
		'a"b': Value(i32(1))
	}
	assert value_to_json_str(m) == '{"a\\"b":1}'
}

// --- map entries must be comma separated ---

fn test_json_map_separates_multiple_entries() {
	m := {
		'a': Value(i32(1))
		'b': Value(i32(2))
		'c': Value(i32(3))
	}
	assert value_to_json_str(m) == '{"a":1,"b":2,"c":3}'
}

fn test_json_map_single_entry_has_no_trailing_comma() {
	m := {
		'only': Value(i32(7))
	}
	assert value_to_json_str(m) == '{"only":7}'
}

// --- runes are characters, and JSON has no character type ---

fn test_json_rune_is_emitted_as_string() {
	assert value_to_json_str(rune(`A`)) == '"A"'
}

fn test_json_rune_escapes_when_needed() {
	assert value_to_json_str(rune(`"`)) == '"\\""'
}

// --- a blank key must not leave a stray element behind ---

fn test_json_blank_field_key_is_omitted() {
	out := loggable_to_json_str(EscFields{
		ar: [
			Field{
				key:   ''
				value: 'dropped'
			},
			Field{
				key:   'ok'
				value: 'kept'
			},
		]
	})
	assert out == '{"ok":"kept"}'
}

fn test_json_only_blank_keys_yields_empty_object() {
	out := loggable_to_json_str(EscFields{
		ar: [Field{
			key:   ''
			value: 'dropped'
		}]
	})
	assert out == '{}'
}

// --- end to end: whatever we emit must actually parse ---

struct RoundTrip {
	quote   string
	slash   string
	newline string
}

fn test_json_output_is_parseable() {
	out := loggable_to_json_str(EscFields{
		ar: [
			Field{
				key:   'quote'
				value: 'say "hi"'
			},
			Field{
				key:   'slash'
				value: 'C:\\tmp'
			},
			Field{
				key:   'newline'
				value: 'a\nb'
			},
		]
	})

	decoded := json2.decode[RoundTrip](out) or {
		assert false, 'emitted invalid JSON: ${out} (${err})'
		return
	}

	assert decoded.quote == 'say "hi"'
	assert decoded.slash == 'C:\\tmp'
	assert decoded.newline == 'a\nb'
}

fn test_json_output_stays_on_one_line() {
	out := loggable_to_json_str(EscFields{
		ar: [Field{
			key:   'multi'
			value: 'a\nb\nc'
		}]
	})
	// a log record must never span physical lines, or line based consumers break
	assert !out.contains('\n')
}
