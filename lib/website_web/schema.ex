defmodule WebsiteWeb.Schema do
  use Absinthe.Schema

  alias WebsiteWeb.Resolvers

  import_types(__MODULE__.Types)

  query do
    @desc "Get all users"
    field :all_users, list_of(:user) do
      middleware(Website.Web.Authentication)
      resolve(&Resolvers.Users.users/3)
      # complexity fn %{limit: limit}, child_complexity ->
      #  limit * child_complexity
      # end
    end

    @desc "Get a single user"
    field :fetch_user, :user do
      middleware(Website.Web.Authentication)
      arg(:id, non_null(:id))
      resolve(&Resolvers.Users.user/3)
    end

    @desc "Get all posts"
    field :all_posts, list_of(:post) do
      middleware(Website.Web.Authentication)
      resolve(&Resolvers.Posts.posts/3)
    end

    @desc "Get a single post"
    field :fetch_post, :post do
      middleware(Website.Web.Authentication)
      arg(:id, non_null(:id))
      resolve(&Resolvers.Posts.post/3)
    end
  end

  mutation do
    field :login, :session do
      arg(:email, non_null(:string))
      arg(:password, non_null(:string))
      resolve(&Resolvers.Users.login/2)
    end

    field :create_user, :user do
      arg(:username, non_null(:string))
      arg(:email, non_null(:string))
      arg(:password, non_null(:string))
      resolve(&Resolvers.Users.create_user/3)
    end

    field :add_post, :post do
      middleware(Website.Web.Authentication)
      arg(:title, non_null(:string))
      arg(:content, non_null(:string))
      resolve(&Resolvers.Posts.add_post/3)
    end
  end
end
