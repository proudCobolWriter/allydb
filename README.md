# AllyDB

An in-memory database similar to Redis, built using Elixir.

## Information

AllyDB is a database that is built using Elixir. It is mostly a learning project, but I will try to make it as usable as possible.

#### Should you use it?

Probably not. It is not as stable and most likely not as fast as Redis or other similar databases.
It also has less features than Redis.

However, if you want to learn how to build a similar project, you can use this project as a reference.

## Roadmap

- [x] Basic key value store
- [x] Lists
- [ ] Usage Guide
- [ ] Persistence
- [ ] Hashes
- [ ] Sets
- [ ] Sorted Sets
- [ ] Pub/Sub

While working on these features, I will be constantly trying to improve the performance of the database.

### Performance Roadmap

(?) means that the item is an idea, but it is unclear how it will be implemented, or how the implementation will look like.

- [ ] Optimize list operations that use the `Enum` module over ETS functions, such as `lrange`.
- [ ] Better usage of ETS (?)
- [ ] Better usage of OTP (?)
