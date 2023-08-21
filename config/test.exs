import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :live_elements_labs, LiveElementsLabs.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  database: "live_elements_labs_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :live_elements_labs, LiveElementsLabsWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "4972o4lRUSB7Pk4bko1Skw4igen9P1UU2xJOIX8FiiVr2x8dFONArcXnByQOi5ax",
  server: true

# In test we don't send emails.
config :live_elements_labs, LiveElementsLabs.Mailer, adapter: Swoosh.Adapters.Test

# Disable swoosh api client as it is only required for production adapters.
config :swoosh, :api_client, false

# Print only warnings and errors during test
config :logger, level: :warning

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime

config :wallaby,
  otp_app: :live_elements_labs,
  base_url: "http://localhost:4002",
  chromedriver: [
    headless: false
  ]
