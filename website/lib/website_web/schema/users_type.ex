defmodule WebsiteWeb.Schema.UsersTypes do
  use Absinthe.Schema.Notation

  object :user do
    field(:id, non_null(:id))
    field(:username, non_null(:string))
    field(:email, non_null(:string))

    field(:posts, list_of(:post)) do
      resolve(&WebsiteWeb.Resolvers.Posts.user_posts/3)
    end
  end
end
