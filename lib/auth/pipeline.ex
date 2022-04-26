defmodule BuscaCepWeb.Auth.Pipeline do
  use Guardian.Plug.Pipeline, otp_app: :busca_cep

  @moduledoc """
    Pipeline to ensure user authentication
  """

  plug Guardian.Plug.VerifyHeader
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource
end
