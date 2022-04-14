defmodule BuscaCepWeb.FetchView do
  use BuscaCepWeb, :view
  @attrs_to_show [:bairro, :cep, :complemento, :logradouro, :localidade]

  def render("show.json", %{cep: cep}) do
    data = Map.take(cep, @attrs_to_show) |> put_cep_hiphen()

    %{data: data}
  end

  defp put_cep_hiphen(%{cep: cep} = cep_info) do
    cep =
      cep
      |> String.replace("-", "")
      |> String.graphemes()
      |> List.insert_at(5, "-")
      |> List.to_string()

    %{cep_info | cep: cep}
  end
end
