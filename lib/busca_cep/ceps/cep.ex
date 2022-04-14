defmodule BuscaCep.Ceps.Cep do
  @moduledoc """
    Cep schema and changeset
  """
  use Ecto.Schema
  import Ecto.Changeset

  @attrs [:bairro, :cep, :complemento, :logradouro, :localidade, :uf]

  schema "ceps" do
    field :bairro, :string
    field :cep, :string
    field :complemento, :string
    field :localidade, :string
    field :logradouro, :string
    field :uf, :string

    timestamps()
  end

  def changeset(cep \\ %__MODULE__{}, attrs) do
    cep
    |> cast(attrs, @attrs)
    |> validate_required([:cep])
    |> unique_constraint(:cep)
    |> sanitaze_cep()
  end

  defp sanitaze_cep(%Ecto.Changeset{changes: %{cep: cep}} = changeset) do
    cep = String.replace(cep, "-", "")

    put_change(changeset, :cep, cep)
  end
end
