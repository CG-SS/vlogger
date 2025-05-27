module vlogger

struct AppendMessageLevelFnTestCase {
	level_fieldname string
	input_msg       DefaultMessage
	output_msg      DefaultMessage
}

fn test_append_message_level_fn() {
	test_ch := chan DefaultMessage{}
	defer { test_ch.close() }

	test_cases := [
		AppendMessageLevelFnTestCase{
			level_fieldname: 'level'
			input_msg:       DefaultMessage{
				level: .none
			}
			output_msg:      DefaultMessage{
				fields: [
					Field{
						key:   'level'
						value: StringValue{MessageLevel.none.str()}
					},
				]
				level:  .none
			}
		},
		AppendMessageLevelFnTestCase{
			level_fieldname: 'message_level'
			input_msg:       DefaultMessage{
				level: .error
			}
			output_msg:      DefaultMessage{
				fields: [
					Field{
						key:   'message_level'
						value: StringValue{MessageLevel.error.str()}
					},
				]
				level:  .error
			}
		},
	]

	for test in test_cases {
		test_fn := append_message_level_fn(test.level_fieldname)
		output := test_fn(test.input_msg) or {
			assert false, 'should not be none'
			return
		}

		assert test.output_msg.str() == output.str()
	}
}
