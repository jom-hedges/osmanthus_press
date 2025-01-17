defmodule OsmanthusPress.Blog.Post do
  use Ash.Resource,
    domain: OsmanthusPress.Blog,
    data_layer: AshPostgres.DataLayer

  postgres do
    table "posts"
    repo OsmanthusPress.Repo
  end

  actions do
    defaults [:read, :destroy]

    create :create do
      accept [:title]
    end

    update :update do
      accept [:content]
    end

    read :by_id do
      argument :id, :uuid, allow_nil?: false
      get? true
      filter expr(id == ^arg(:id))
    end
  end

  attributes do
    uuid_primary_key :id
    attribute :title, :string do
      allow_nil? false
    end

    attribute :content, :string
    create_timestamp :inserted_at
    update_timestamp :updated_at
  end
end
