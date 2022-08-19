import Config

config :cicob,
  ecto_repos: [Cicob.Repo]

# Configures the endpoint
config :cicob, CicobWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [view: CicobWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: Cicob.PubSub,
  live_view: [signing_salt: "+vr1qcAn"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

import_config "#{config_env()}.exs"
