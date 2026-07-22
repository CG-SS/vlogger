module vlogger

struct FilterByLevelTestCase {
	message DefaultMessage
}

fn test_filter_by_level_fn() {
	test_cases := [
		FilterByLevelTestCase{
			message: DefaultMessage{
				level: .none
			}
		},
		FilterByLevelTestCase{
			message: DefaultMessage{
				level: .debug
			}
		},
		FilterByLevelTestCase{
			message: DefaultMessage{
				level: .info
			}
		},
		FilterByLevelTestCase{
			message: DefaultMessage{
				level: .warn
			}
		},
		FilterByLevelTestCase{
			message: DefaultMessage{
				level: .fatal
			}
		},
	]

	logger_level := MessageLevel.info
	filter_fn := filter_by_level_fn(logger_level)

	for test in test_cases {
		filter_fn(test.message) or { assert u8(test.message.level) < u8(logger_level) }
	}
}
