defmodule BuscaCepWeb.FallbackController do
  @moduledoc """
  Translates controller action results into valid `Plug.Conn` responses.

  See `Phoenix.Controller.action_fallback/1` for more details.
  """
  use BuscaCepWeb, :controller

  # This clause handles errors returned by Ecto's insert/update/delete.
  def call(conn, {:error, %Ecto.Changeset{} = changeset}) do
    conn
    |> put_status(:unprocessable_entity)
    |> put_view(BuscaCepWeb.ChangesetView)
    |> render("error.json", changeset: changeset)
  end

  # This clause is an example of how to handle resources that cannot be found.
  def call(conn, {:error, :not_found}) do
    conn
    |> put_status(:not_found)
    |> put_view(BuscaCepWeb.ErrorView)
    |> render(:"404")
  end

  def call(conn, {:error, %{message: "Invalid format"}}) do
    conn
    |> put_status(:bad_request)
    |> put_view(BuscaCepWeb.ErrorView)
    |> render("error.json", message: "Invalid format")
  end

  def call(conn, {:error, %{message: "Unexpected error"}}) do
    conn
    |> put_status(:internal_server_error)
    |> put_view(BuscaCepWeb.ErrorView)
    |> render("error.json", message: "Unexpected error")
  end

  def call(conn, {:error, %{message: "CEP Not found"}}) do
    conn
    |> put_status(:not_found)
    |> put_view(BuscaCepWeb.ErrorView)
    |> render("error.json", message: "CEP Not found")
  end

  def call(conn, {:error, %{status: status, message: message}}) do
    conn
    |> put_status(status)
    |> put_view(BuscaCepWeb.ErrorView)
    |> render("error.json", message: message)
  end
end
