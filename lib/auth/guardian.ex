defmodule BuscaCepWeb.Auth.Guardian do
  @moduledoc """
    Decode, verify and generate JWT
    Documentation: https://hexdocs.pm/guardian/readme.html
  """
  use Guardian, otp_app: :busca_cep

  def subject_for_token(%{id: id}, _claims) do
    sub = to_string(id)

    {:ok, sub}
  end

  def resource_from_claims(%{"sub" => id}) do
    resource = BuscaCep.get_user_by_id(id)

    {:ok, resource}
  end
end
