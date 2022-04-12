defmodule BuscaCep.GetCep do
  @moduledoc """
    Behaviour responsable for getting CEP info
  """
  @callback call(Strint.t()) :: {:ok, map()} | {:error, map()}

  def call(cep) do
    impl().call(cep)
  end

  defp impl do
    Application.get_env(:busca_cep, :get_cep)
  end
end
