# vlogger

A structured JSON logger for Vlang with support for method chaining.

Defaults to writing messages asynchronously using an internal channel.

## Usage

```vlang
mut level_writer := vlogger.SingleWriter{
		error_handler: fn (e IError) {println(e)}
		writer: os.stdout()
	}

log := vlogger.new_logger().with_buffer_size(4096).logger(mut level_writer)
log.info().kv("hello", "there").kv("test", true).kv("n", 1).send()
```


