import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :busca_cep, BuscaCep.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  database: "busca_cep_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :busca_cep, BuscaCepWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "Gq0YVIZlyJB4zX2TKVAnv3WzDIAfvKtBJ0b7FAzs7Nu/W3QYJaRe1NCQDpY5UBiZ",
  server: false

# In test we don't send emails.
config :busca_cep, BuscaCep.Mailer, adapter: Swoosh.Adapters.Test

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime

# Configures bcrypt
config :bcrypt_elixir, :log_rounds, 4
