defmodule OsmanthusPress.Repo.Migrations.CreateArticles do
  use Ecto.Migration

  def change do
    create table(:articles) do
      add :title, :string
      add :content, :text
      add :author, :string
      add :published_at, :naive_datetime
      add :slug, :string, unique: true

      timestamps()
    end

    create unique_index(:articles, [:slug])
  end
end
