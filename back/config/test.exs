import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
# config :time_manager, TimeManager.Repo,
#   username: "postgres",
#   password: "postgres",
#   hostname: "localhost",
#   database: "time_manager_test#{System.get_env("MIX_TEST_PARTITION")}",
#   pool: Ecto.Adapters.SQL.Sandbox,
#   pool_size: 10

config :time_manager, TimeManager.Repo,
  username: String.replace(System.get_env("PGUSER"), "\r", ""),
  password: String.replace(System.get_env("PGPASSWORD"), "\r", ""),
  hostname: String.replace(System.get_env("PGHOST"), "\r", ""),
  database: String.replace(System.get_env("PGDATABASE"), "\r", ""),
  stacktrace: true,
  show_sensitive_data_on_connection_error: true,
  pool_size: 10

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :time_manager, TimeManagerWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "RGUNwvVqhnz5r8ReGa1//4GLffUfK5wMwS90P7KIiWPV8ISJ6KLuKS95SXlgQrxt",
  server: false

# In test we don't send emails.
config :time_manager, TimeManager.Mailer, adapter: Swoosh.Adapters.Test

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
