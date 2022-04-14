defmodule BuscaCepWeb.FetchController do
  use BuscaCepWeb, :controller

  action_fallback BuscaCepWeb.FallbackController

  def fetch(conn, %{"cep" => cep} = _params) do
    with {:ok, cep_info} <- BuscaCep.fetch(cep) do
      conn
      |> put_status(:ok)
      |> render("show.json", cep: cep_info)
    end
  end
end
