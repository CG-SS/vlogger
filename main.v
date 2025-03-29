module main

import vlogger
import time

fn main() {
	logger := vlogger.DefaultLogger.new()
	logger.info().bool('hello', false).send().send().send()
	time.sleep(1 * time.second)
}
