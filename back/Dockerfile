FROM elixir:latest

RUN apt-get update -y && apt-get install -y postgresql-client inotify-tools

RUN mkdir /back
COPY . /back
WORKDIR /back

ARG PGUSER
ARG PGPASSWORD
ARG PGDATABASE
ARG PGHOST
ARG PGPORT
ARG ORIGIN_DOMAIN

ENV PGUSER=$PGUSER
ENV PGPASSWORD=$PGPASSWORD
ENV PGDATABASE=$PGDATABASE
ENV PGHOST=$PGHOST
ENV PGPORT=$PGPORT
ENV ORIGIN_DOMAIN=$ORIGIN_DOMAIN

# RUN mix local.hex --force
# # RUN RUN mix archive.install hex phx_new
# # RUN RUN mix archive.install --force hex phx_new
# # RUN ecto.create
# # RUN ecto.migrate

# RUN mix local.rebar --force

# RUN mix deps.get

# RUN mix ecto.create

# RUN mix ecto.migrate

CMD [ "/back/entrypoint.sh" ]