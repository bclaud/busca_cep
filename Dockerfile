FROM elixir:latest as build

RUN mkdir /app
WORKDIR /app

# install hex + rebar
RUN mix do local.hex --force, local.rebar --force

# set build ENV, in that case, DEV
ENV MIX_ENV=dev

# install mix dependencies
COPY mix.exs mix.lock ./
COPY config config
RUN mix deps.get
RUN mix deps.compile

# BUILD PROJECT 
COPY priv priv
COPY lib lib
RUN mix compile

# Start phoenix server. Only for dev env
EXPOSE 4000

CMD sleep 5 && mix ecto.setup && mix phx.server
