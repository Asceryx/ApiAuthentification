# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Api.Repo.insert!(%Api.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
IO.puts("Adding a couple of users...")
Api.Account.create_user(%{email: "user1@email.com", password: "qwerty", username: "user1"})
Api.Account.create_user(%{email: "user2@email.com", password: "asdfgh", username: "user2"})