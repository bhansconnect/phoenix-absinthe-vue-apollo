defmodule WebsiteWeb.Schema.PostsTypes do
  use Absinthe.Schema.Notation

  object :post do
    field(:id, non_null(:id))
    field(:title, non_null(:string))
    field(:slug, non_null(:string))
    field(:content, non_null(:string))
    field(:user, non_null(:user))
  end
end
