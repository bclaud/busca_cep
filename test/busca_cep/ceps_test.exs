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
      {:ok, cep} = Ceps.create(@valid_cep)

      response_with_hyphen = Ceps.get_by_cep("09999-999")

      assert %{
               bairro: "any bairro",
               cep: "09999999",
               complemento: "any complemento",
               localidade: "Any Cidade",
               logradouro: "Any Rua",
               id: _id
             } = response

      assert cep == response
    end
  end
end
