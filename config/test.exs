use Mix.Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :bank_api, BankAPI.Repo,
  username: "postgres",
  password: "postgres",
  database: "bank_api_test#{System.get_env("MIX_TEST_PARTITION")}",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :bank_api, BankAPIWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

config :bank_api, BankAPI.App,
  event_store: [
    adapter: Commanded.EventStore.Adapters.InMemory,
    event_store: BankAPI.EventStore
  ]

config :bank_api, BankAPI.EventStore,
  username: "postgres",
  password: "postgres",
  database: "bank_api_eventstore_test",
  hostname: "localhost"
