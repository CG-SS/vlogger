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
	defer { logger.close() }

	logger.info().bool('hello', false).message('hello there')
}
```

`default` fixes the level at `.info`, so `trace` and `debug` are discarded. Use
`new` to choose a level:

```vlang
logger := vlogger.new(vlogger.LoggerCfg{
	write_fn: vlogger.write_json_message_fn(fn (_ IError) {}, mut out)
	message:  vlogger.MessageCfg{
		level: .trace
	}
})
```

Levels run `trace < debug < info < warn < error < fatal < none`. A threshold of
`.trace` lets everything through; `.none` suppresses everything.

`message()` is terminal: it adds the message field and sends the record, so
nothing can be chained after it.

## Logging your own types

A type that should appear as a nested object implements `Loggable`:

```vlang
struct User {
	name string
	age  i32
}

fn (u User) fields() []vlogger.Field {
	return [
		vlogger.Field{ key: 'name', value: u.name },
		vlogger.Field{ key: 'age',  value: u.age },
	]
}

logger.info().strut('user', User{'John', 19}).send()
```

A type that should appear as a scalar it formats itself implements `Renderable`:

```vlang
struct Ip {
	octets []u8
}

fn (i Ip) render() string {
	return i.octets.map(it.str()).join('.')
}

logger.info().custom('bind', Ip{[u8(192), 168, 0, 1]}).send()
```

## Writing your own output format

`write_fn` takes any `fn (vlogger.Loggable)`. A `Value` is a sum type, so a
`match` over it is checked for exhaustiveness and each branch already holds the
payload at its real type:

```vlang
fn to_yaml(v vlogger.Value) string {
	match v {
		bool { return v.str() }
		string { return v }
		i32 { return v.str() }
		// ... remaining variants
		else { return '' }
	}
}
```
