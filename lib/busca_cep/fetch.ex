defmodule BuscaCep.Fetch do
  @moduledoc """
    This module is responsable for fetching CEP info from any available source. eg. Repo or API
  """

  alias BuscaCep.Ceps
  alias BuscaCep.GetCep

  def call(cep) do
    case Ceps.get_by_cep(cep) do
      {:error, _reason} -> fetch_from_api(cep)
      {:ok, _cep} = cep -> cep
    end
  end

  defp fetch_from_api(cep) do
    case GetCep.call(cep) do
      {:error, _reason} = error -> error
      {:ok, cep_info} -> handle_cep_info(cep_info)
    end
  end

  defp handle_cep_info(cep_info) do
    Task.start_link(fn -> Ceps.create(cep_info) end)

    cep =
      cep_info
      |> Map.new(fn {k, v} -> {String.to_atom(k), v} end)
      |> sanitaze_cep()

    {:ok, cep}
  end

  defp sanitaze_cep(%{cep: cep} = cep_info) do
    cep = String.replace(cep, "-", "")

    %{cep_info | cep: cep}
  end
end
