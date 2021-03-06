defmodule BuscaCepWeb.UserController do
  use BuscaCepWeb, :controller

  alias BuscaCep.Users
  alias BuscaCep.Users.User
  alias BuscaCepWeb.Auth.Guardian, as: Auth

  action_fallback BuscaCepWeb.FallbackController

  def index(conn, _params) do
    users = Users.list_users()
    render(conn, "index.json", users: users)
  end

  def create(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- Users.create_user(user_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.user_path(conn, :show, user))
      |> render("show.json", user: user)
    end
  end

  def show(conn, %{"id" => id}) do
    with {:ok, user} <- Users.get_user(id) do
      render(conn, "show.json", user: user)
    end
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    {:ok, user} = Users.get_user(id)

    with {:ok, %User{} = user} <- Users.update_user(user, user_params) do
      render(conn, "show.json", user: user)
    end
  end

  def delete(conn, %{"id" => id}) do
    {:ok, user} = Users.get_user(id)

    with {:ok, %User{}} <- Users.delete_user(user) do
      send_resp(conn, :no_content, "")
    end
  end

  def authenticate(conn, params) do
    with {:ok, token} <- Auth.authenticate(params) do
      conn
      |> put_status(:ok)
      |> render("token.json", token: token)
    end
  end
end
