defmodule WebsiteWeb.Resolvers.Posts do
  import Slug, only: [slugify: 2]

  def posts(_, _, _) do
    {:ok, Website.Posts.list_posts()}
  end

  def user_posts(%{id: user_id}, _, _) do
    {:ok, Website.Posts.get_user_posts(user_id)}
  end

  def post(_, %{slug: slug}, _) do
    case Website.Posts.get_post_by_slug(slug) do
      nil ->
        {:error, "Post #{slug} not found"}

      post ->
        {:ok, post}
    end
  end

  def add_post(_, %{title: title, content: content}, %{context: %{current_user: current_user}}) do
    Website.Posts.create_post(current_user, %{
      title: title,
      slug: slugify(title, separator: ?_, lowercase: true),
      content: content
    })
  end
end
