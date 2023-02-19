# AllyDB

[![Made with Elixir](https://forthebadge.com/images/badges/made-with-elixir.svg)](https://elixir-lang.org/)

[![Latest Docker Image Version](https://img.shields.io/docker/v/allyedge/allydb?color=lightblue&label=Latest%20Docker%20Image%20Version&style=for-the-badge)](https://hub.docker.com/r/allyedge/allydb)

[![License](https://img.shields.io/github/license/allyedge/allydb?style=for-the-badge)](https://github.com/Allyedge/allydb/blob/main/LICENSE)

An in-memory database similar to Redis, built using Elixir.

## Information

AllyDB is a database that is built using Elixir. It is mostly a learning project, but I will try to make it as usable as possible.

#### Should you use it?

Probably not.

It is not as stable and most likely not as fast as Redis or other similar databases.
It also has less features than Redis.

However, if you want to learn how to build a similar project, you can use this project as a reference.

(~) means that the feature is implemented, but might not be stable or completely finished.

## Roadmap

- [x] Basic key value store
- [x] Lists
- [x] Usage Guide
- [x] Persistence (~)
- [x] Hashes
- [ ] Sets
- [ ] Sorted Sets
- [ ] Pub/Sub

While working on these features, I will be constantly trying to improve the performance of the database.

### Performance Roadmap

(?) means that the item is an idea, but it is unclear how it will be implemented, or how the implementation will look like.

- [ ] Better usage of OTP (?)
- [ ] Better usage of ETS (?)

### Development Roadmap

- [ ] Testing
- [ ] Improve the naming of things in the code

## Usage

### Environment Variables

| Name                   | Description                                          | Default      |
| ---------------------- | ---------------------------------------------------- | ------------ |
| `ALLYDB_PORT`          | The port on which the server will listen             | `4000`       |
| `PERSISTENCE_LOCATION` | The location where the database will be persisted    | `allydb.tab` |
| `PERSISTENCE_INTERVAL` | The interval at which the database will be persisted | `3000`       |

### Installation

#### Using Docker

You can use the docker image to run the database.

```sh
> docker pull allyedge/allydb

> docker run -p 4000:4000 allyedge/allydb
```

#### Build from source

You can also build the project from source.

```sh
> git clone https://github.com/Allyedge/allydb

> cd allydb

> mix deps.get

> mix compile

> mix release --env=prod

> _build/prod/rel/allydb/bin/allydb start
```

## Documentation

You can find the documentation [here](docs/DOCUMENTATION.md).

## Persistence

The database is persisted to a file using ETS. The file is located at `allydb.tab` by default.

The database is persisted on a regular interval and not on every change. The interval is 3000ms by default.

This means that if you make a change to the database, it might not be persisted immediately.

You can change the persistence interval using the `PERSISTENCE_INTERVAL` environment variable (in milliseconds) to make it persist more often, but this might mean a higher CPU and disk usage.

## License

AllyDB is licensed under the Apache License 2.0. You can find the license [here](LICENSE).
