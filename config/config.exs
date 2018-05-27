# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# Configures the endpoint
config :websocket_chat, WebsocketChatWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "5QP5cIrnsRiTviu1Cv5X2ueBeXOFi31+aAOz1T2MbjIYfBFQCm4mwVlnnDoSGbDi",
  render_errors: [view: WebsocketChatWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: WebsocketChat.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
