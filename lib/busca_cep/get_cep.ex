defmodule BuscaCep.GetCep do
  @moduledoc """
    Behaviour responsable for getting CEP info
  """
  alias BuscaCep.Ceps.Cep
  @callback call(String.t()) :: {:ok, Cep.t()} | {:error, map()}

  def call(cep) do
    impl().call(cep)
  end

  defp impl do
    Application.get_env(:busca_cep, :get_cep)
  end
end
