defmodule BuscaCep.Emails.SendCepReport do
  @moduledoc """
  Send cep Report Email template
  """
  import Swoosh.Email

  @path "priv/uploads/ceps/"

  alias BuscaCep.Mailer

  def send(email, filename) do
    new()
    |> to({"", email})
    |> from({"Busca Cep App", "app@mail.com"})
    |> subject("Ceps report")
    |> text_body("Here is your Ceps Report")
    |> attachment(@path <> filename)
    |> Mailer.deliver()
  end
end
