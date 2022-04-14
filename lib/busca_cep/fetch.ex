defmodule BuscaCep.Fetch do
  @moduledoc """
    This module is responsable for fetching CEP info from any available source. eg. Repo or API
  """

  alias BuscaCep.Ceps
  alias BuscaCep.GetCep

  def call(cep) do
    case Ceps.get_by_cep(cep) do
      {:error, _reason} -> fetch_from_api(cep)
      {:ok, cep} -> cep
    end
  end

  defp fetch_from_api(cep) do
    case GetCep.call(cep) do
      {:error, _reason} = error -> error
      {:ok, cep_info} -> handle_cep_info(cep_info)
    end
  end

  defp handle_cep_info(cep_info) do
    Task.async(fn -> Ceps.create(cep_info) end)

    {:ok, cep_info}
  end
end
