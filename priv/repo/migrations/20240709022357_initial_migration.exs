defmodule OsmanthusPress.Repo.Migrations.InitialMigration do
  @moduledoc """
  Updates resources based on their most recent snapshots.

  This file was autogenerated with `mix ash_postgres.generate_migrations`
  """

  use Ecto.Migration

  def up do
    create table(:posts, primary_key: false) do
      add :id, :uuid, null: false, default: fragment("gen_random_uuid()"), primary_key: true
      add :title, :text, null: false
      add :content, :text
    end
  end

  def down do
    drop table(:posts)
  end
end
