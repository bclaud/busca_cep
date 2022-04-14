defmodule BuscaCep.Ceps do
  @moduledoc """
   Ceps context.
  """
  alias BuscaCep.Repo

  alias BuscaCep.Ceps.Cep

  def get_by_cep(cep) do
    cep = String.replace(cep, "-", "")

    case Repo.get_by(Cep, cep: cep) do
      nil -> {:error, "CEP Not found"}
      %Cep{} = inserted_cep -> {:ok, inserted_cep}
    end
  end

  def create(attrs \\ %{}) do
    %Cep{}
    |> Cep.changeset(attrs)
    |> Repo.insert()
  end
end
