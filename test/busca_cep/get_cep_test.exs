defmodule BuscaCep.GetCepTest do
  use ExUnit.Case, async: true

  import Mox

  alias BuscaCep.GetCep

  @valid_cep %{
    "bairro" => "any bairro",
    "cep" => "09999-999",
    "complemento" => "any complemento",
    "ddd" => "11",
    "gia" => "6350",
    "ibge" => "3548708",
    "localidade" => "Any Cidade",
    "logradouro" => "Any Rua",
    "siafi" => "7075",
    "uf" => "SP"
  }

  describe "call/1" do
    test "Should return an error if invalid format is provided" do
      expect(BuscaCep.GetCep.Mock, :call, fn arg ->
        assert arg == "invalid_format"
        {:error, %{message: "Invalid format"}}
      end)

      response = GetCep.call("invalid_format")

      assert response == {:error, %{message: "Invalid format"}}
    end

    test "Should return an error if CEP is not found" do
      expect(BuscaCep.GetCep.Mock, :call, fn arg ->
        assert arg == "Non existent CEP"
        {:error, %{message: "CEP Not found"}}
      end)

      response = GetCep.call("Non existent CEP")

      assert response == {:error, %{message: "CEP Not found"}}
    end

    test "Should return unexpected error" do
      expect(BuscaCep.GetCep.Mock, :call, fn arg ->
        assert arg == "unexpected error"
        {:error, %{message: "Unexpected Error"}}
      end)

      response = GetCep.call("unexpected error")

      assert response == {:error, %{message: "Unexpected Error"}}
    end

    test "Should return a CEP when valid CEP is provided" do
      expect(BuscaCep.GetCep.Mock, :call, fn arg ->
        assert arg == "valid_cep"
        {:ok, @valid_cep}
      end)

      response = GetCep.call("valid_cep")

      assert response == {:ok, @valid_cep}
    end
  end
end
