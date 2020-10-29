defmodule Api.Account.Role do
  use Ecto.Schema
  import Ecto.Changeset

  schema "roles" do
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(role, attrs) do
    role
    |> cast(attrs, [:id ,:name])
    |> validate_required([:id, :name])
  end
end
