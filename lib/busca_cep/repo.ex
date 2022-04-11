defmodule BuscaCep.Repo do
  use Ecto.Repo,
    otp_app: :busca_cep,
    adapter: Ecto.Adapters.Postgres
end
