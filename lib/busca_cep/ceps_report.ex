defmodule BuscaCep.CepsReport do
  @moduledoc """
  Module responsible for generating Ceps reports
  """

  @header ["cep", "uf", "localidade", "logradouro", "bairro", "complemento"]
  @path "priv/uploads/ceps/"

  alias BuscaCep.Ceps
  alias NimbleCSV.Spreadsheet, as: CSV

  def generate_all do
    data =
      Ceps.report_list()
      |> put_header()
      |> CSV.dump_to_iodata()

    filename = now() <> "ceps.csv"

    File.write!(@path <> filename, data)
  end

  defp put_header(ceps_row) do
    [@header | ceps_row]
  end

  defp now do
    NaiveDateTime.utc_now() |> NaiveDateTime.to_string()
  end
end
