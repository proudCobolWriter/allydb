FROM elixir:1.14-alpine as build

RUN apk add --update git

RUN mkdir /app
WORKDIR /app

ENV MIX_ENV=prod

RUN mix local.hex --force && \
    mix local.rebar --force

COPY mix.exs ./
COPY deps ./
RUN mix deps.compile

COPY . .
RUN mix release

FROM alpine:latest

RUN apk add --update bash openssl libstdc++ ncurses-libs

RUN mkdir /app && chown -R nobody: /app

WORKDIR /app
USER nobody

COPY --from=build /app/_build/prod/rel/allydb ./

ENV REPLACE_OS_VARS=true
ENV HTTP_PORT=4000 BEAM_PORT=14000 ERL_EPMD_PORT=24000
EXPOSE $HTTP_PORT $BEAM_PORT $ERL_EPMD_PORT

ENTRYPOINT ["/app/bin/allydb", "start"]