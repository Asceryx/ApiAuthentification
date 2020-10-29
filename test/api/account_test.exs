defmodule Api.AccountTest do
  use Api.DataCase

  alias Api.Account

  describe "users" do
    alias Api.Account.User

    @valid_attrs %{email: "some email", username: "some username", password: "some password"}
    @update_attrs %{email: "some updated email", username: "some updated username", password: "some updated password"}
    @invalid_attrs %{email: nil, username: nil, password: nil}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Account.create_user()

      user
    end

    def user_without_password(attrs \\ %{}) do
      %{user_fixture(attrs) | password: nil}
    end

    test "list_users/0 returns all users" do
      user = user_without_password()
      assert Account.list_users() == [user]
    end


    test "get_user!/1 returns the user with given id" do
      user = user_without_password()
      assert Account.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Account.create_user(@valid_attrs)
      assert user.email == "some email"
      assert user.username == "some username"
      assert Bcrypt.verify_pass("some password", user.password_hash)
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Account.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_without_password()
      assert {:ok, %User{} = user} = Account.update_user(user, @update_attrs)
      assert user.email == "some updated email"
      assert user.username == "some updated username"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_without_password()
      assert {:error, %Ecto.Changeset{}} = Account.update_user(user, @invalid_attrs)
      assert user == Account.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_without_password()
      assert {:ok, %User{}} = Account.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Account.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_without_password()
      assert %Ecto.Changeset{} = Account.change_user(user)
    end
  end

  describe "roles" do
    alias Api.Account.Role

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def role_fixture(attrs \\ %{}) do
      {:ok, role} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Account.create_role()

      role
    end

    test "list_roles/0 returns all roles" do
      role = role_fixture()
      assert Account.list_roles() == [role]
    end

    test "get_role!/1 returns the role with given id" do
      role = role_fixture()
      assert Account.get_role!(role.id) == role
    end

    test "create_role/1 with valid data creates a role" do
      assert {:ok, %Role{} = role} = Account.create_role(@valid_attrs)
      assert role.name == "some name"
    end

    test "create_role/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Account.create_role(@invalid_attrs)
    end

    test "update_role/2 with valid data updates the role" do
      role = role_fixture()
      assert {:ok, %Role{} = role} = Account.update_role(role, @update_attrs)
      assert role.name == "some updated name"
    end

    test "update_role/2 with invalid data returns error changeset" do
      role = role_fixture()
      assert {:error, %Ecto.Changeset{}} = Account.update_role(role, @invalid_attrs)
      assert role == Account.get_role!(role.id)
    end

    test "delete_role/1 deletes the role" do
      role = role_fixture()
      assert {:ok, %Role{}} = Account.delete_role(role)
      assert_raise Ecto.NoResultsError, fn -> Account.get_role!(role.id) end
    end

    test "change_role/1 returns a role changeset" do
      role = role_fixture()
      assert %Ecto.Changeset{} = Account.change_role(role)
    end
  end
end
