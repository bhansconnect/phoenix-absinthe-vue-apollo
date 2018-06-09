defmodule WebsiteWeb.Resolvers.Users do
  import Website.AuthHelper

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

  def login(%{email: email, password: password}, _info) do
    with {:ok, user} <- login_with_email_pass(email, password),
         {:ok, jwt, _} <- Website.Guardian.encode_and_sign(user),
         {:ok, _} <- Website.Accounts.store_token(user, jwt) do
      {:ok, %{token: jwt}}
    end
  end

  def create_user(_, args, _) do
    Website.Accounts.create_user(args)
  end
end
