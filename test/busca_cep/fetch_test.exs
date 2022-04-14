defmodule BuscaCep.FetchTest do
  use BuscaCep.DataCase

  import Mox

  alias BuscaCep.Ceps
  alias BuscaCep.Fetch

  @valid_cep %{
    bairro: "any bairro",
    cep: "09999-999",
    complemento: "any complemento",
    localidade: "Any Cidade",
    logradouro: "Any Rua"
  }

  describe "fetch" do
    test "call/1 Returns an inserted_cep when valid Cep is provided" do
      {:ok, cep} = Ceps.create(@valid_cep)

      response = Fetch.call("09999999")

      assert cep == response
    end

    test "call/1 Returns an cep when valid Cep is provided" do
      expect(BuscaCep.GetCep.Mock, :call, fn arg ->
        assert arg == "09999999"
        {:ok, @valid_cep}
      end)

      response = Fetch.call("09999999")

      assert {:ok, @valid_cep} == response
    end
  end
end
