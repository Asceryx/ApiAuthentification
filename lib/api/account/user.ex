defmodule Api.Account.User do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :integer
  schema "users" do
    field :email, :string
    field :username, :string
    field :password, :string, virtual: true
    field :password_hash, :string

    belongs_to :role, Api.Account.Role

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:email, :username, :password, :role_id])
    |> validate_required([:email, :username, :role_id])
    |> unique_constraint(:username)
    |> put_password_hash()
  end

  defp put_password_hash(
      %Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset
    ) do
    change(changeset, Bcrypt.add_hash(password))
  end

  defp put_password_hash(changeset) do
    changeset
  end
end
