defmodule ApiWeb.UserController do
  use ApiWeb, :controller

  alias Api.Account
  alias Api.Account.User

  action_fallback ApiWeb.FallbackController

  def index(conn, _params) do
    users = Account.list_users()
    render(conn, "index.json", users: users)
  end

  def create(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- Account.create_user(user_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.user_path(conn, :show, user))
      |> render("show.json", user: user)
    end
  end

  def show(conn, %{"id" => id}) do
    user = Account.get_user!(id)
    render(conn, "show.json", user: user)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Account.get_user!(id)

    with {:ok, %User{} = user} <- Account.update_user(user, user_params) do
      render(conn, "show.json", user: user)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Account.get_user!(id)

    with {:ok, %User{}} <- Account.delete_user(user) do
      send_resp(conn, :no_content, "")
    end
  end

  @spec sign_in(Plug.Conn.t(), map) :: Plug.Conn.t()
  def sign_in(conn, %{"username" => username, "password" => password}) do
    {:ok, token, _} = Api.Token.generate_and_sign()
    case Account.authenticate_user(username, password) do
      {:ok, user} ->
        conn
        |> put_session(:current_user_id, user.id)
        |> configure_session(renew: true)
        |> put_status(:ok)
        |> put_view(ApiWeb.UserView)
        |> render("sign_in.json", user: user, token: token)

      {:error, message} ->
        conn
        |> delete_session(:current_user_id)
        |> put_status(:unauthorized)
        |> put_view(ApiWeb.ErrorView)
        |> render("401.json", message: message)
    end
  end
end
