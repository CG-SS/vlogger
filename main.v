module main

import vlogger

fn main() {
	logger := vlogger.DefaultLogger.new()

	logger.debug().bool("hello", false).send()
}