module main

import vlogger
import time
import os

fn main() {
	mut out := os.stdout()
	defer { out.close() }

	logger := vlogger.default(mut out)

	logger.info().bool('hello', false).send()
	logger.debug().u8('number', 8).string('test', 'this is a test').f32('float_val', 3.66).send()
	logger.info().bool('hello', false).message('hello there')
	logger.error().f64('number', 776.54323).message('another number')
	time.sleep(1 * time.second)
}
