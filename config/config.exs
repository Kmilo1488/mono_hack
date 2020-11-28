# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :mono_hack,
  ecto_repos: [MonoHack.Repo]

# Configures the endpoint
config :mono_hack, MonoHackWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "HQ65w5CaYa1F6jltzzhMmQiM7GSPfgYndT7YzFOSmYwzBpBcGa1tRGZBUTZ+GqbM",
  render_errors: [view: MonoHackWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: MonoHack.PubSub,
  live_view: [signing_salt: "+MZuFkIA"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
