# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :busca_cep,
  ecto_repos: [BuscaCep.Repo]

# Configures the endpoint
config :busca_cep, BuscaCepWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [view: BuscaCepWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: BuscaCep.PubSub,
  live_view: [signing_salt: "wWLji89+"]

# Configures tesla adapter
config :tesla, adapter: Tesla.Adapter.Hackney
# Configures the mailer
#
# By default it uses the "Local" adapter which stores the emails
# locally. You can see the emails in your browser, at "/dev/mailbox".
#
# For production it's recommended to configure a different adapter
# at the `config/runtime.exs`.
config :busca_cep, BuscaCep.Mailer, adapter: Swoosh.Adapters.Local

# Swoosh API client is needed for adapters other than SMTP.
config :swoosh, :api_client, false

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"

# Configures JWT
config :busca_cep, BuscaCepWeb.Auth.Guardian,
  issuer: "Busca Cep",
  secret_key:
    System.get_env(
      "JWTSECRETKEY",
      "2Us5Uckp9sysMf84Tyz0FtLYtsDDAmaZopparDfYGEFvgXaeM0VQ+RcUYqfw+DPW"
    )

# Configures JWT Pipeline
config :busca_cep, BuscaCepWeb.Auth.Pipeline,
  module: BuscaCepWeb.Auth.Guardian,
  error_handler: BuscaCepWeb.Auth.ErrorHandler
