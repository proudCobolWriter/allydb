# [AllyDB](https://allydb.vercel.app/)

[![Made with Elixir](https://forthebadge.com/images/badges/made-with-elixir.svg)](https://elixir-lang.org/)

[![Latest Docker Image Version](https://img.shields.io/docker/v/allyedge/allydb?color=lightblue&label=Latest%20Docker%20Image%20Version&style=for-the-badge)](https://hub.docker.com/r/allyedge/allydb)

[![License](https://img.shields.io/github/license/allyedge/allydb?style=for-the-badge)](https://github.com/Allyedge/allydb/blob/main/LICENSE)

[![Documentation](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIyNDguNTEiIGhlaWdodD0iMzUiIHZpZXdCb3g9IjAgMCAyNDguNTEgMzUiPjxyZWN0IGNsYXNzPSJzdmdfX3JlY3QiIHg9IjAiIHk9IjAiIHdpZHRoPSI2OC4zIiBoZWlnaHQ9IjM1IiBmaWxsPSIjRDM1QjA5Ii8+PHJlY3QgY2xhc3M9InN2Z19fcmVjdCIgeD0iNjYuMyIgeT0iMCIgd2lkdGg9IjE4Mi4yMDk5OTk5OTk5OTk5OCIgaGVpZ2h0PSIzNSIgZmlsbD0iI0UyODg0OCIvPjxwYXRoIGNsYXNzPSJzdmdfX3RleHQiIGQ9Ik0xNi41MSAyMkwxMy40NiAxMy40N0wxNS4wOCAxMy40N0wxNy4yMiAyMC4xNEwxOS4zOSAxMy40N0wyMS4wMiAxMy40N0wxNy45NSAyMkwxNi41MSAyMlpNMjYuNTMgMjJMMjUuMDYgMjJMMjUuMDYgMTMuNDdMMjYuNTMgMTMuNDdMMjYuNTMgMjJaTTMwLjkxIDE5LjQyTDMwLjkxIDE5LjQyTDMyLjM5IDE5LjQyUTMyLjM5IDIwLjE1IDMyLjg3IDIwLjU1UTMzLjM1IDIwLjk1IDM0LjI1IDIwLjk1TDM0LjI1IDIwLjk1UTM1LjAyIDIwLjk1IDM1LjQxIDIwLjYzUTM1LjgwIDIwLjMyIDM1LjgwIDE5LjgwTDM1LjgwIDE5LjgwUTM1LjgwIDE5LjI0IDM1LjQxIDE4Ljk0UTM1LjAxIDE4LjYzIDMzLjk4IDE4LjMyUTMyLjk1IDE4LjAxIDMyLjM0IDE3LjYzTDMyLjM0IDE3LjYzUTMxLjE3IDE2LjkwIDMxLjE3IDE1LjcyTDMxLjE3IDE1LjcyUTMxLjE3IDE0LjY5IDMyLjAyIDE0LjAyUTMyLjg2IDEzLjM1IDM0LjIwIDEzLjM1TDM0LjIwIDEzLjM1UTM1LjA5IDEzLjM1IDM1Ljc5IDEzLjY4UTM2LjQ4IDE0LjAxIDM2Ljg4IDE0LjYxUTM3LjI4IDE1LjIyIDM3LjI4IDE1Ljk2TDM3LjI4IDE1Ljk2TDM1LjgwIDE1Ljk2UTM1LjgwIDE1LjI5IDM1LjM4IDE0LjkxUTM0Ljk3IDE0LjU0IDM0LjE5IDE0LjU0TDM0LjE5IDE0LjU0UTMzLjQ2IDE0LjU0IDMzLjA2IDE0Ljg1UTMyLjY2IDE1LjE2IDMyLjY2IDE1LjcxTDMyLjY2IDE1LjcxUTMyLjY2IDE2LjE4IDMzLjA5IDE2LjUwUTMzLjUyIDE2LjgxIDM0LjUyIDE3LjEwUTM1LjUyIDE3LjQwIDM2LjEyIDE3Ljc4UTM2LjcyIDE4LjE2IDM3LjAwIDE4LjY1UTM3LjI5IDE5LjEzIDM3LjI5IDE5Ljc5TDM3LjI5IDE5Ljc5UTM3LjI5IDIwLjg2IDM2LjQ3IDIxLjQ5UTM1LjY1IDIyLjEyIDM0LjI1IDIyLjEyTDM0LjI1IDIyLjEyUTMzLjMyIDIyLjEyIDMyLjU1IDIxLjc3UTMxLjc3IDIxLjQzIDMxLjM0IDIwLjgzUTMwLjkxIDIwLjIyIDMwLjkxIDE5LjQyWk00My4xNCAyMkw0MS42NiAyMkw0MS42NiAxMy40N0w0My4xNCAxMy40N0w0My4xNCAyMlpNNDkuNjMgMTQuNjZMNDYuOTkgMTQuNjZMNDYuOTkgMTMuNDdMNTMuNzYgMTMuNDdMNTMuNzYgMTQuNjZMNTEuMTAgMTQuNjZMNTEuMTAgMjJMNDkuNjMgMjJMNDkuNjMgMTQuNjZaIiBmaWxsPSIjRkZGRkZGIi8+PHBhdGggY2xhc3M9InN2Z19fdGV4dCIgZD0iTTg0LjQ2IDIyTDgwLjQ5IDIyTDgwLjQ5IDEzLjYwTDg0LjQ2IDEzLjYwUTg1Ljg0IDEzLjYwIDg2LjkxIDE0LjEyUTg3Ljk4IDE0LjYzIDg4LjU3IDE1LjU4UTg5LjE1IDE2LjUzIDg5LjE1IDE3LjgwTDg5LjE1IDE3LjgwUTg5LjE1IDE5LjA3IDg4LjU3IDIwLjAyUTg3Ljk4IDIwLjk3IDg2LjkxIDIxLjQ4UTg1Ljg0IDIyIDg0LjQ2IDIyTDg0LjQ2IDIyWk04Mi44NyAxNS41MEw4Mi44NyAyMC4xMEw4NC4zNyAyMC4xMFE4NS40NCAyMC4xMCA4Ni4xMCAxOS40OVE4Ni43NSAxOC44OCA4Ni43NSAxNy44MEw4Ni43NSAxNy44MFE4Ni43NSAxNi43MiA4Ni4xMCAxNi4xMVE4NS40NCAxNS41MCA4NC4zNyAxNS41MEw4NC4zNyAxNS41MEw4Mi44NyAxNS41MFpNOTMuNDUgMTcuODBMOTMuNDUgMTcuODBROTMuNDUgMTYuNTUgOTQuMDYgMTUuNTVROTQuNjYgMTQuNTYgOTUuNzMgMTQuMDBROTYuNzkgMTMuNDMgOTguMTIgMTMuNDNMOTguMTIgMTMuNDNROTkuNDUgMTMuNDMgMTAwLjUxIDE0LjAwUTEwMS41OCAxNC41NiAxMDIuMTggMTUuNTVRMTAyLjc5IDE2LjU1IDEwMi43OSAxNy44MEwxMDIuNzkgMTcuODBRMTAyLjc5IDE5LjA1IDEwMi4xOCAyMC4wNFExMDEuNTggMjEuMDQgMTAwLjUyIDIxLjYwUTk5LjQ1IDIyLjE3IDk4LjEyIDIyLjE3TDk4LjEyIDIyLjE3UTk2Ljc5IDIyLjE3IDk1LjczIDIxLjYwUTk0LjY2IDIxLjA0IDk0LjA2IDIwLjA0UTkzLjQ1IDE5LjA1IDkzLjQ1IDE3LjgwWk05NS44NSAxNy44MEw5NS44NSAxNy44MFE5NS44NSAxOC41MSA5Ni4xNSAxOS4wNVE5Ni40NSAxOS42MCA5Ni45NyAxOS45MFE5Ny40OSAyMC4yMCA5OC4xMiAyMC4yMEw5OC4xMiAyMC4yMFE5OC43NiAyMC4yMCA5OS4yNyAxOS45MFE5OS43OSAxOS42MCAxMDAuMDkgMTkuMDVRMTAwLjM5IDE4LjUxIDEwMC4zOSAxNy44MEwxMDAuMzkgMTcuODBRMTAwLjM5IDE3LjA5IDEwMC4wOSAxNi41NFE5OS43OSAxNiA5OS4yNyAxNS43MFE5OC43NiAxNS40MCA5OC4xMiAxNS40MEw5OC4xMiAxNS40MFE5Ny40OCAxNS40MCA5Ni45NyAxNS43MFE5Ni40NSAxNiA5Ni4xNSAxNi41NFE5NS44NSAxNy4wOSA5NS44NSAxNy44MFpNMTA3LjA5IDE3LjgwTDEwNy4wOSAxNy44MFExMDcuMDkgMTYuNTQgMTA3LjY5IDE1LjU0UTEwOC4yOCAxNC41NSAxMDkuMzQgMTMuOTlRMTEwLjM5IDEzLjQzIDExMS43MSAxMy40M0wxMTEuNzEgMTMuNDNRMTEyLjg2IDEzLjQzIDExMy43OCAxMy44NFExMTQuNzEgMTQuMjUgMTE1LjMyIDE1LjAyTDExNS4zMiAxNS4wMkwxMTMuODEgMTYuMzlRMTEzLjAwIDE1LjQwIDExMS44MyAxNS40MEwxMTEuODMgMTUuNDBRMTExLjE0IDE1LjQwIDExMC42MSAxNS43MFExMTAuMDggMTYgMTA5Ljc4IDE2LjU0UTEwOS40OSAxNy4wOSAxMDkuNDkgMTcuODBMMTA5LjQ5IDE3LjgwUTEwOS40OSAxOC41MSAxMDkuNzggMTkuMDVRMTEwLjA4IDE5LjYwIDExMC42MSAxOS45MFExMTEuMTQgMjAuMjAgMTExLjgzIDIwLjIwTDExMS44MyAyMC4yMFExMTMuMDAgMjAuMjAgMTEzLjgxIDE5LjIyTDExMy44MSAxOS4yMkwxMTUuMzIgMjAuNThRMTE0LjcxIDIxLjM1IDExMy43OSAyMS43NlExMTIuODYgMjIuMTcgMTExLjcxIDIyLjE3TDExMS43MSAyMi4xN1ExMTAuMzkgMjIuMTcgMTA5LjM0IDIxLjYxUTEwOC4yOCAyMS4wNSAxMDcuNjkgMjAuMDVRMTA3LjA5IDE5LjA2IDEwNy4wOSAxNy44MFpNMTE5Ljc5IDE4LjI2TDExOS43OSAxOC4yNkwxMTkuNzkgMTMuNjBMMTIyLjE3IDEzLjYwTDEyMi4xNyAxOC4xOVExMjIuMTcgMjAuMjAgMTIzLjc2IDIwLjIwTDEyMy43NiAyMC4yMFExMjUuMzQgMjAuMjAgMTI1LjM0IDE4LjE5TDEyNS4zNCAxOC4xOUwxMjUuMzQgMTMuNjBMMTI3LjY5IDEzLjYwTDEyNy42OSAxOC4yNlExMjcuNjkgMjAuMTMgMTI2LjY1IDIxLjE1UTEyNS42MSAyMi4xNyAxMjMuNzQgMjIuMTdMMTIzLjc0IDIyLjE3UTEyMS44NiAyMi4xNyAxMjAuODIgMjEuMTVRMTE5Ljc5IDIwLjEzIDExOS43OSAxOC4yNlpNMTM0Ljk3IDIyTDEzMi43NyAyMkwxMzIuNzcgMTMuNjBMMTM0LjczIDEzLjYwTDEzNy42OCAxOC40NUwxNDAuNTYgMTMuNjBMMTQyLjUyIDEzLjYwTDE0Mi41NCAyMkwxNDAuMzYgMjJMMTQwLjM0IDE3LjU1TDEzOC4xNyAyMS4xN0wxMzcuMTIgMjEuMTdMMTM0Ljk3IDE3LjY3TDEzNC45NyAyMlpNMTU0LjQ0IDIyTDE0Ny43MCAyMkwxNDcuNzAgMTMuNjBMMTU0LjI5IDEzLjYwTDE1NC4yOSAxNS40NEwxNTAuMDYgMTUuNDRMMTUwLjA2IDE2Ljg1TDE1My43OSAxNi44NUwxNTMuNzkgMTguNjNMMTUwLjA2IDE4LjYzTDE1MC4wNiAyMC4xN0wxNTQuNDQgMjAuMTdMMTU0LjQ0IDIyWk0xNjEuNTggMjJMMTU5LjI1IDIyTDE1OS4yNSAxMy42MEwxNjEuMjEgMTMuNjBMMTY0LjkyIDE4LjA3TDE2NC45MiAxMy42MEwxNjcuMjQgMTMuNjBMMTY3LjI0IDIyTDE2NS4yOSAyMkwxNjEuNTggMTcuNTJMMTYxLjU4IDIyWk0xNzQuMjAgMTUuNDhMMTcxLjYxIDE1LjQ4TDE3MS42MSAxMy42MEwxNzkuMTQgMTMuNjBMMTc5LjE0IDE1LjQ4TDE3Ni41NyAxNS40OEwxNzYuNTcgMjJMMTc0LjIwIDIyTDE3NC4yMCAxNS40OFpNMTg0LjkzIDIyTDE4Mi41MCAyMkwxODYuMjEgMTMuNjBMMTg4LjU1IDEzLjYwTDE5Mi4yNyAyMkwxODkuODAgMjJMMTg5LjE0IDIwLjM3TDE4NS41OSAyMC4zN0wxODQuOTMgMjJaTTE4Ny4zNiAxNS45M0wxODYuMjggMTguNjFMMTg4LjQ0IDE4LjYxTDE4Ny4zNiAxNS45M1pNMTk4LjIxIDE1LjQ4TDE5NS42MyAxNS40OEwxOTUuNjMgMTMuNjBMMjAzLjE1IDEzLjYwTDIwMy4xNSAxNS40OEwyMDAuNTkgMTUuNDhMMjAwLjU5IDIyTDE5OC4yMSAyMkwxOTguMjEgMTUuNDhaTTIwOS45MCAyMkwyMDcuNTMgMjJMMjA3LjUzIDEzLjYwTDIwOS45MCAxMy42MEwyMDkuOTAgMjJaTTIxNC42NSAxNy44MEwyMTQuNjUgMTcuODBRMjE0LjY1IDE2LjU1IDIxNS4yNSAxNS41NVEyMTUuODYgMTQuNTYgMjE2LjkyIDE0LjAwUTIxNy45OCAxMy40MyAyMTkuMzEgMTMuNDNMMjE5LjMxIDEzLjQzUTIyMC42NCAxMy40MyAyMjEuNzEgMTQuMDBRMjIyLjc3IDE0LjU2IDIyMy4zOCAxNS41NVEyMjMuOTggMTYuNTUgMjIzLjk4IDE3LjgwTDIyMy45OCAxNy44MFEyMjMuOTggMTkuMDUgMjIzLjM4IDIwLjA0UTIyMi43NyAyMS4wNCAyMjEuNzEgMjEuNjBRMjIwLjY1IDIyLjE3IDIxOS4zMSAyMi4xN0wyMTkuMzEgMjIuMTdRMjE3Ljk4IDIyLjE3IDIxNi45MiAyMS42MFEyMTUuODYgMjEuMDQgMjE1LjI1IDIwLjA0UTIxNC42NSAxOS4wNSAyMTQuNjUgMTcuODBaTTIxNy4wNSAxNy44MEwyMTcuMDUgMTcuODBRMjE3LjA1IDE4LjUxIDIxNy4zNSAxOS4wNVEyMTcuNjUgMTkuNjAgMjE4LjE3IDE5LjkwUTIxOC42OCAyMC4yMCAyMTkuMzEgMjAuMjBMMjE5LjMxIDIwLjIwUTIxOS45NSAyMC4yMCAyMjAuNDcgMTkuOTBRMjIwLjk4IDE5LjYwIDIyMS4yOCAxOS4wNVEyMjEuNTggMTguNTEgMjIxLjU4IDE3LjgwTDIyMS41OCAxNy44MFEyMjEuNTggMTcuMDkgMjIxLjI4IDE2LjU0UTIyMC45OCAxNiAyMjAuNDcgMTUuNzBRMjE5Ljk1IDE1LjQwIDIxOS4zMSAxNS40MEwyMTkuMzEgMTUuNDBRMjE4LjY4IDE1LjQwIDIxOC4xNiAxNS43MFEyMTcuNjUgMTYgMjE3LjM1IDE2LjU0UTIxNy4wNSAxNy4wOSAyMTcuMDUgMTcuODBaTTIzMS4wNCAyMkwyMjguNzEgMjJMMjI4LjcxIDEzLjYwTDIzMC42NyAxMy42MEwyMzQuMzggMTguMDdMMjM0LjM4IDEzLjYwTDIzNi43MCAxMy42MEwyMzYuNzAgMjJMMjM0Ljc1IDIyTDIzMS4wNCAxNy41MkwyMzEuMDQgMjJaIiBmaWxsPSIjRkZGRkZGIiB4PSI3OS4zIi8+PC9zdmc+)](https://allydb.vercel.app/)

An in-memory database similar to Redis, built using Elixir.

## Information

AllyDB is a database that is built using Elixir. It is mostly a learning project, but I will try to make it as usable as possible.

## Should you use it?

Probably not.

It is not as stable and most likely not as fast as Redis or other similar databases.
It also has less features than Redis.

However, if you want to learn how to build a similar project, you can use this project as a reference.

## Roadmap

- [x] Basic key value store
- [x] Lists
- [x] Usage Guide
- [x] Persistence
- [x] Hashes
- [ ] Sets
- [ ] Sorted Sets
- [ ] Pub/Sub

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

You can find the documentation [here](https://allydb.vercel.app).

## Example Usage

### Basic Key Value Store

```sh
> SET hello world
world

> GET hello
world

> DEL hello
hello
```

### Lists

```sh
> lpush list 1
1

> lpush list 2
2

> lpush list 3
3

> lpop list
3
```

### Hashes

```sh
> hset user id 1 name john age 20
3

> hget user name
john

> hgetall user
age
20
id
1
name
john

> hdel user age
1
```

## Persistence

The database is persisted to a file using ETS. The file is located at `allydb.tab` by default.

The database is persisted on a regular interval and not on every change. The interval is `3000ms` by default.

This means that if you make a change to the database, it might not be persisted immediately.

You can change the persistence interval using the `PERSISTENCE_INTERVAL` environment variable (in milliseconds) to make it persist more often, but this might mean a higher CPU and disk usage.

## License

AllyDB is licensed under the Apache License 2.0. You can find the license [here](LICENSE).
