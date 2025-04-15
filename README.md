# vlogger

A structured JSON logger for Vlang with support for method chaining.

Defaults to writing messages asynchronously using an internal channel.

## Usage

```vlang
import os
import vlogger

fn main() {
	mut out := os.stdout()
	defer { out.close() }

	logger := vlogger.default(mut out)
	defer {logger.close()}

	logger.trace().bool('hello', false).send()
}
```


