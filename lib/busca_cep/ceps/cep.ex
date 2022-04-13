defmodule BuscaCep.Ceps.Cep do
  use Ecto.Schema
  import Ecto.Changeset

  @attrs [:bairro, :cep, :complemento, :logradouro, :localidade]

  schema "ceps" do
    field :bairro, :string
    field :cep, :string
    field :complemento, :string
    field :localidade, :string
    field :logradouro, :string

    timestamps()
  end

  def changeset(cep \\ %__MODULE__{}, attrs) do
    cep
    |> cast(attrs, @attrs)
    |> validate_required([:cep])
    |> unique_constraint(:cep)
  end
end
