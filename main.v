module main

import io
import os
import time
import vlogger

fn main() {
	mut level_writer := vlogger.SingleWriter{
		error_handler: fn (e IError) {
			println(e)
		}
		writer: os.stdout()
	}

	log := vlogger.new_logger().with_buffer_size(4096).logger(mut level_writer)
	log.info().kv('hello', 'bozo').kv('bilbo', 'baggins').kv('test', true).kv('n', 999).send()
	log.info().kv('hello', 'bozo').kv('bilbo', 'baggins').kv('test', true).kv('n', 999).send()
	log.info().kv('hello', 'bozo').kv('bilbo', 'baggins').kv('test', true).kv('n', 999).send()
	log.info().kv('hello', 'bozo').kv('bilbo', 'baggins').kv('test', true).kv('n', 999).send()
	log.info().kv('hello', 'bozo').kv('bilbo', 'baggins').kv('test', true).kv('n', 999).send()

	time.sleep(1 * time.second)

	println(time.now().format_rfc3339())
	println(time.utc().utc_to_local().format_rfc3339())
}
