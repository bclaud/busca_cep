defmodule BuscaCep do
  @moduledoc """
  BuscaCep keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """

  defdelegate fetch(cep), to: BuscaCep.Fetch, as: :call
end
