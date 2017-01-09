FROM elixir:1.3.2
MAINTAINER Sergey Gernyak <sergio@alterego-labs.com>

ARG TARGET_CCY
ARG PRIVAT_CLIENT_ID
ARG PRIVAT_CLIENT_SECRET
ARG SLACK_NOTIFICATION_HOOK_URL

ENV MIX_ENV=prod
ENV TARGET_CCY ${TARGET_CCY}
ENV PRIVAT_CLIENT_ID ${PRIVAT_CLIENT_ID}
ENV PRIVAT_CLIENT_SECRET ${PRIVAT_CLIENT_SECRET}
ENV SLACK_NOTIFICATION_HOOK_URL ${SLACK_NOTIFICATION_HOOK_URL}

RUN apt-get update && apt-get install -y build-essential git-core mysql-client

RUN mkdir -p /app

WORKDIR /app

RUN mix local.hex --force
RUN mix local.rebar --force

COPY . ./

RUN mix do deps.get, deps.compile
RUN mix compile
RUN mix release --verbosity=verbose

CMD ["rel/privat_curses_puller/bin/privat_curses_puller", "console"]
