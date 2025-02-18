#!/bin/bash

# # while ! pg_isready -h $PGHOST -p $PGPORT -U $PGUSER
# # do
# #   echo "$(date) - waiting for database to start"
# #   sleep 2
# # done

# # Create, migrate, and seed database if it doesn't exist.
# if [[ -z `psql -Atqc "\\list $PGDATABASE"` ]]; then
#   echo "Database $PGDATABASE does not exist. Creating..."
#   createdb -E UTF8 $PGDATABASE -l en_US.UTF-8 -T template0
#   mix ecto.migrate
#   mix run priv/repo/seeds.exs
#   echo "Database $PGDATABASE created."
# fi

# exec mix phx.server

mix local.hex --force
# RUN mix archive.install hex phx_new
# RUN mix archive.install --force hex phx_new
# RUN ecto.create
# RUN ecto.migrate

mix local.rebar --force

mix deps.get

mix ecto.create

mix ecto.migrate

exec mix phx.server