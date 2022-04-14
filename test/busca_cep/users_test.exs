defmodule BuscaCep.UsersTest do
  use BuscaCep.DataCase

  alias BuscaCep.Users

  describe "users" do
    alias BuscaCep.Users.User

    import BuscaCep.UsersFixtures

    @invalid_attrs %{email: nil, name: nil, password: nil}

    test "list_users/0 returns all users" do
      user = user_fixture()

      [inserted_user | _tail] = Users.list_users()
      assert inserted_user.name == user.name
      assert inserted_user.email == user.email
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()

      %{name: sut_name, email: sut_email, password_hash: _} = Users.get_user!(user.id)

      assert user.name == sut_name
      assert user.email == sut_email
    end

    test "create_user/1 with valid data creates a user" do
      valid_attrs = %{email: "some email", name: "some name", password: "some password"}

      assert {:ok, %User{} = user} = Users.create_user(valid_attrs)
      assert user.email == "some email"
      assert user.name == "some name"
      assert user.password == "some password"
    end

    test "create_user/1 with duplicated email returns error" do
      valid_attrs = %{email: "some email", name: "some name", password: "some password"}
      Users.create_user(valid_attrs)

      assert {:error, %Ecto.Changeset{valid?: false, errors: [email: _result]}} =
               Users.create_user(valid_attrs)
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Users.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()

      update_attrs = %{
        email: "some updated email",
        name: "some updated name",
        password: "some updated password"
      }

      assert {:ok, %User{} = user} = Users.update_user(user, update_attrs)
      assert user.email == "some updated email"
      assert user.name == "some updated name"
      assert user.password == "some updated password"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Users.update_user(user, @invalid_attrs)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Users.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Users.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Users.change_user(user)
    end
  end
end
