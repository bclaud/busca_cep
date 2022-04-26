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
    {:ok, resource} = BuscaCep.get_user_by_id(id)

    {:ok, resource}
  end

  def authenticate(%{"id" => user_id, "password" => password}) do
    with {:ok, %{password_hash: hash} = user} <- BuscaCep.get_user_by_id(user_id),
         true <- Bcrypt.verify_pass(password, hash),
         {:ok, token, _claims} <- encode_and_sign(user) do
      {:ok, token}
    else
      {:error, %{message: message}} -> {:error, %{status: :not_found, message: message}}
      false -> {:error, %{status: :unauthorized, message: "Verify your credentials"}}
    end
  end

  def authenticate(_), do: {:error, %{status: :bad_request, message: "Invalid or missing params"}}
end
