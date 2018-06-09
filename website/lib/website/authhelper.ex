defmodule Website.AuthHelper do
  @moduledoc false

  import Comeonin.Argon2, only: [checkpw: 2, dummy_checkpw: 0]
  alias Website.Repo
  alias Website.Accounts.User

  def login_with_email_pass(email, given_pass) do
    case Repo.get_by(User, email: String.downcase(email)) do
      nil ->
        dummy_checkpw()
        {:error, :"Incorrect login credentials"}

      user ->
        case checkpw(given_pass, user.password_hash) do
          true ->
            {:ok, user}

          false ->
            {:error, :"Incorrect login credentials"}
        end
    end
  end
end
