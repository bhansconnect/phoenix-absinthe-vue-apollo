defmodule Website.Repo.Migrations.CreatePosts do
  use Ecto.Migration

  def change do
    create table(:posts) do
      add(:user_id, references(:users), null: false)
      add(:title, :string, null: false)
      add(:slug, :string, null: false)
      add(:content, :text, null: false)

      timestamps()
    end

    create(unique_index(:posts, [:slug]))
  end
end
