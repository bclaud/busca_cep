defmodule BuscaCep.GetCep.ViaCep do
  @moduledoc """
  This module provides CEP info from Via CEP API
  """

  use Tesla

  alias BuscaCep.GetCep

  plug Tesla.Middleware.BaseUrl, "https://viacep.com.br/ws/"
  plug Tesla.Middleware.JSON

  @behaviour GetCep

  def call(cep) do
    get(cep <> "/json")
    |> handle_get()
  end

  defp handle_get({:ok, %Tesla.Env{status: 200, body: %{"erro" => "true"}}}),
    do: {:error, %{message: "CEP Not found"}}

  defp handle_get({:ok, %Tesla.Env{status: 200, body: cep}}), do: {:ok, cep}

  defp handle_get({:ok, %Tesla.Env{status: 400, body: _body}}),
    do: {:error, %{message: "Invalid format"}}

  defp handle_get({:error, _reason}), do: {:error, %{message: "Unexpected error"}}

  defp handle_get(_), do: {:error, %{message: "Unexpected error"}}
end
