module vlogger

import time

struct AppendTimestampTestCase {
	append_fn     HookFn @[required]
	expect_format string
}

fn test_append_timestamp_fn_normal_formats() {
	// TODO: update test cases when time.parse_format supports units smaller than ss
	test_cases := [
		AppendTimestampTestCase{
			append_fn:     append_timestamp_fn(TimestampFormat.default, 'timestamp')
			expect_format: 'YYYY-MM-DD HH:mm'
		},
		AppendTimestampTestCase{
			append_fn:     append_timestamp_fn(TimestampFormat.ss, 'timestamp')
			expect_format: 'YYYY-MM-DD HH:mm:ss'
		},
	]

	for test in test_cases {
		out := test.append_fn(DefaultMessage{}) or {
			assert false, 'should not be none'
			return
		}

		fields := out.fields()

		assert fields.len == 1
		assert fields[0].key == 'timestamp'

		field_value := fields[0].value
		match field_value {
			StringValue {
				time.parse_format(field_value.value, test.expect_format) or {
					assert false, 'parse_format failed: ${err}'
				}
			}
			else {
				assert false, 'should be a StringValue'
			}
		}
	}
}

struct AppendTimestampSingleFormatTestCase {
	append_fn HookFn @[required]
}

fn test_append_timestamp_fn_rfc3339_format() {
	test_cases := [
		AppendTimestampSingleFormatTestCase{
			append_fn: append_timestamp_fn(TimestampFormat.rfc3339, 'timestamp')
		},
		AppendTimestampSingleFormatTestCase{
			append_fn: append_timestamp_fn(TimestampFormat.rfc3339_micro, 'timestamp')
		},
		AppendTimestampSingleFormatTestCase{
			append_fn: append_timestamp_fn(TimestampFormat.rfc3339_nano, 'timestamp')
		},
	]

	for test in test_cases {
		out := test.append_fn(DefaultMessage{}) or {
			assert false, 'should not be none'
			return
		}

		fields := out.fields()

		assert fields.len == 1
		assert fields[0].key == 'timestamp'

		field_value := fields[0].value
		match field_value {
			StringValue {
				time.parse_rfc3339(field_value.value) or {
					assert false, 'parse_rfc3339 failed: ${err}'
				}
			}
			else {
				assert false, 'should be a StringValue'
			}
		}
	}
}

fn test_append_timestamp_fn_unix_format() {
	test_cases := [
		AppendTimestampSingleFormatTestCase{
			append_fn: append_timestamp_fn(TimestampFormat.unix, 'timestamp')
		},
		AppendTimestampSingleFormatTestCase{
			append_fn: append_timestamp_fn(TimestampFormat.unix_nano, 'timestamp')
		},
		AppendTimestampSingleFormatTestCase{
			append_fn: append_timestamp_fn(TimestampFormat.unix_milli, 'timestamp')
		},
		AppendTimestampSingleFormatTestCase{
			append_fn: append_timestamp_fn(TimestampFormat.unix_micro, 'timestamp')
		},
	]

	for test in test_cases {
		out := test.append_fn(DefaultMessage{}) or {
			assert false, 'should not be none'
			return
		}

		fields := out.fields()

		assert fields.len == 1
		assert fields[0].key == 'timestamp'

		field_value := fields[0].value
		match field_value {
			I64Value {}
			else {
				assert false, 'should be a I64Value'
			}
		}
	}
}
