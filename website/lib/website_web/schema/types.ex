defmodule WebsiteWeb.Schema.Types do
  use Absinthe.Schema.Notation

  object :user do
    field(:id, non_null(:id))
    field(:username, non_null(:string))
    field(:email, non_null(:string))

    field(:posts, list_of(:post)) do
      resolve(&WebsiteWeb.Resolvers.Posts.user_posts/3)
    end
  end

  object :post do
    field(:id, non_null(:id))
    field(:title, non_null(:string))
    field(:slug, non_null(:string))
    field(:content, non_null(:string))
    field(:user, non_null(:user))
  end

  object :session do
    field(:token, :string)
  end
end
