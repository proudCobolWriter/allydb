# Usage

## Connecting

AllyDB uses a TCP server to communicate with clients.

To connect to the server, you must first create a socket and connect to the server.

The server port is 4000 by default, but you can change it by setting the `ALLYDB_PORT` environment variable to something else.

### Example

```sh
> telnet 127.0.0.1 4000
```

## Commands

AllyDB commands are similar to Redis. They are case-insensitive and end with a newline character.

### Example of a command

```sh
> COMMAND arg1 arg2
```

### Example of running a command in Node.js

```js
const net = require("net");

const client = net.createConnection(4000, () => {
  client.write("COMMAND arg1 arg2\n");
});
```

## Basic commands

### `PING`

Check if the server is alive.

#### Example

```sh
> PING
PONG
```

### `GET <key>`

Get the value of a key.

#### Example

```sh
# Exists
> GET foo
bar

# Doesn't exist
> GET bar
```

### `SET <key> <value>`

Set the value of a key.

#### Example

```sh
> SET foo bar
bar

> SET another 123

> SET user:1:name John Doe
```

### `DEL <key>`

Delete a key.

#### Example

```sh
> DEL foo
foo
```

## List commands

### `LPUSH <key> <value>`

Push a value to the left of a list. Create a list if it doesn't exist.

#### Example

```sh
> LPUSH list 1
1
```

### `LPUSHX <key> <value>`

Push a value to the left of a list only if the list exists.

#### Example

```sh
# List doesn't exist
> LPUSHX list 1

# List exists
> LPUSH list 1
1

> LPUSHX list 2
2
```

### `RPUSH <key> <value>`

Push a value to the right of a list. Create a list if it doesn't exist.

#### Example

```sh
> RPUSH list 2
2
```

### `RPUSHX <key> <value>`

Push a value to the right of a list only if the list exists.

#### Example

```sh
# List doesn't exist
> RPUSHX list 1

# List exists
> RPUSH list 1
1

> RPUSHX list 2
2
```

### `LPOP <key>`

Pop a value from the left of a list. Return nothing if the list is empty.

#### Example

```sh
> LPOP list
1

> LPOP list
2

# Empty list
> LPOP list
```

### `RPOP <key>`

Pop a value from the right of a list. Return nothing if the list is empty.

#### Example

```sh
> RPOP list
2

> RPOP list
1

# Empty list
> RPOP list
```

### `LLEN <key>`

Get the length of a list.

#### Example

```sh
> LPUSH list 1
1

> LPUSH list 2
2

> LLEN list
2
```

### `LTRIM <key> <start> <stop>`

Trim a list to the specified range.

#### Example

```sh
> LPUSH list 1
1

> LPUSH list 2
2

> LPUSH list 3
3

> LTRIM list 0 1
ok
```

### `LINDEX <key> <index>`

Get the value at the specified index of a list.

#### Example

```sh
> LPUSH list 1
1

> LPUSH list 2
2

> LPUSH list 3
3

> LINDEX list 0
3
```

### `LRANGE <key> <start> <stop>`

Get a range of values from a list.

#### Example

```sh
> LPUSH list 1
1

> LPUSH list 2
2

> LPUSH list 3
3

> LRANGE list 0 1
3
2
```

### `LPOS <key> <value>`

Get the index of the first occurrence of a value in a list.

#### Example

```sh
> LPUSH list 1
1

> LPUSH list 2
2

> LPUSH list 3
3

> LPOS list 2
1
```

### `LREM <key> <value>`

Remove all occurrences of a value from a list.

#### Example

```sh
> LPUSH list 1
1

> LPUSH list 2
2

> LPUSH list 3
3

> LREM list 2
1
```

### `LINSERT <key> <position> <pivot> <value>`

Insert a value before or after a pivot in a list.

#### Example

```sh
> LPUSH list 1
1

> LPUSH list 2
2

> LPUSH list 3
3

> LINSERT list BEFORE 2 4
1
```

### `LSET <key> <index> <value>`

Set the value at the specified index of a list.

#### Example

```sh
> LPUSH list 1
1

> LPUSH list 2
2

> LPUSH list 3
3

> LSET list 1 4
4

> LRANGE list 0 2
3
4
1
```
