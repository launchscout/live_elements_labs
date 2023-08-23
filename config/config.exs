# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :live_elements_labs,
  ecto_repos: [LiveElementsLabs.Repo],
  guild_id: 553_656_304_154_050_563,
  bot_id: 1_009_927_559_217_168_384

config :live_elements_labs, LiveElementsLabs.Repo,
  types: LiveElementsLabs.PostgresTypes,
  extensions: [{Geo.PostGIS.Extension, library: Geo}]

# Configures the endpoint
config :live_elements_labs, LiveElementsLabsWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [
    formats: [html: LiveElementsLabsWeb.ErrorHTML, json: LiveElementsLabsWeb.ErrorJSON],
    layout: false
  ],
  pubsub_server: LiveElementsLabs.PubSub,
  live_view: [signing_salt: "oP86X709"]

# Configures the mailer
#
# By default it uses the "Local" adapter which stores the emails
# locally. You can see the emails in your browser, at "/dev/mailbox".
#
# For production it's recommended to configure a different adapter
# at the `config/runtime.exs`.
config :live_elements_labs, LiveElementsLabs.Mailer, adapter: Swoosh.Adapters.Local

# Configure esbuild (the version is required)
config :esbuild,
  version: "0.17.11",
  default: [
    args:
      ~w(js/app.js --bundle --target=es2017 --outdir=../priv/static/assets --external:/fonts/* --external:/images/*),
    cd: Path.expand("../assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ],
  custom_elements: [
    args:
      ~w(js/custom_elements.ts --bundle --target=es2020 --format=esm --outdir=../priv/static/assets --external:/fonts/* --external:/images/*),
    cd: Path.expand("../assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

# Configure tailwind (the version is required)
config :tailwind,
  version: "3.2.7",
  default: [
    args: ~w(
      --config=tailwind.config.js
      --input=css/app.css
      --output=../priv/static/assets/app.css
    ),
    cd: Path.expand("../assets", __DIR__)
  ]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :nostrum,
  token: System.get_env("DISCORD_BOT_TOKEN"),
  gateway_intents: :all

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
