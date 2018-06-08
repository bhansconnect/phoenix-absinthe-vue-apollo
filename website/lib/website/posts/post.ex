defmodule Website.Posts.Post do
  use Ecto.Schema
  import Ecto.Changeset

  schema "posts" do
    field(:content, :string)
    field(:slug, :string)
    field(:title, :string)
    field(:user_id, :integer)

    has_one(:user, Website.Accounts.User, foreign_key: :id)

    timestamps()
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:user_id, :title, :slug, :content])
    |> validate_required([:user_id, :title, :slug, :content])
    |> unique_constraint(:slug)
  end
end
