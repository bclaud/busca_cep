defmodule BuscaCep.Ceps do
  @moduledoc """
   Ceps context.
  """
  import Ecto.Query, only: [from: 2]

  alias BuscaCep.Ceps.Cep
  alias BuscaCep.Repo

  def list_all do
    Repo.all(Cep)
  end

  def report_list do
    query =
      from c in "ceps", select: [c.cep, c.uf, c.localidade, c.logradouro, c.bairro, c.complemento]

    Repo.all(query)
  end

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
