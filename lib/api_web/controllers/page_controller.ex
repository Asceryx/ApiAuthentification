defmodule ApiWeb.PageController do
  use ApiWeb, :controller

  def index(conn, _params) do
    send_resp(conn, :ok, "Phoenix API is enabled")
  end
end
