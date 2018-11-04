# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Website.Repo.insert!(%Website.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
import Slug, only: [slugify: 2]

alias Website.{Accounts, Posts}

user = %Accounts.User{}
  |> Accounts.User.changeset(%{username: "johndoe", email: "foo@bar.baz", password: "testtest"})
  |> Website.Repo.insert!

title = "This is a title"

Posts.create_post(user, %{
  content: "This is a post",
  title: title,
  slug: slugify(title, separator: ?_, lowercase: true)})
