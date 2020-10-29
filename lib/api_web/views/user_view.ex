defmodule ApiWeb.UserView do
  use ApiWeb, :view
  alias ApiWeb.UserView

  def render("index.json", %{users: users}) do
    %{data: render_many(users, UserView, "user.json")}
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, UserView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{id: user.id, email: user.email, username: user.username}
  end

  def render("sign_in.json", %{user: user, token: token}) do
    %{
      data: %{
        user: %{
          user_id: user.id,
          role_id: user.role_id,
          token: token
        }
      }
    }
  end
end
