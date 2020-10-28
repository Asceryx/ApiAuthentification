ExUnit.start(exclude: [:pending])
Ecto.Adapters.SQL.Sandbox.mode(Api.Repo, {:shared, self()})
