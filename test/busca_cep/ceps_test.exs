defmodule BuscaCep.CepsTest do
  use BuscaCep.DataCase

  alias BuscaCep.Ceps

  @valid_cep %{
    bairro: "any bairro",
    cep: "09999-999",
    complemento: "any complemento",
    localidade: "Any Cidade",
    logradouro: "Any Rua"
  }

  describe "ceps" do
    alias BuscaCep.Ceps.Cep
    alias BuscaCep.Repo

    test "create/1 returns an inserted cep when provided attrs are provided" do
      {:ok, %{id: id} = cep} = Ceps.create(@valid_cep)

      inserted_cep = Repo.get(Cep, id)

      assert inserted_cep == cep
    end

    test "get_by_cep/1 returns an inserted cep info" do
      inserted_cep = Ceps.create(@valid_cep)

      response_with_hyphen = Ceps.get_by_cep("09999-999")
      response = Ceps.get_by_cep("09999999")

      assert inserted_cep == response_with_hyphen

      assert inserted_cep == response
    end
  end
end
