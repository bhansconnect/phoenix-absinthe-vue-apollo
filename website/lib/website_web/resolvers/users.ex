defmodule WebsiteWeb.Resolvers.Users do
  def users(_, _, _) do
    {:ok, Website.Accounts.list_users()}
  end

  def user(_, %{id: id}, _) do
    case Website.Accounts.get_user(id) do
      nil ->
        {:error, "User ID #{id} not found"}

      user ->
        {:ok, user}
    end
  end

  def login(_, _, _) do
    {:ok, nil}
  end

  def create_user(_, args, _) do
    Website.Accounts.create_user(args)
  end
end
