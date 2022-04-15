defmodule BuscaCep.Repo.Migrations.CreateCeps do
  use Ecto.Migration

  def change do
    create table(:ceps) do
      add :bairro, :string
      add :cep, :string
      add :complemento, :string
      add :logradouro, :string
      add :localidade, :string
      add :uf, :string

      timestamps()
    end

    create unique_index(:ceps, [:cep])
  end
end
