defmodule OsmanthusPress.Blog.Post do
  # Using Ash.Resource makes this module an Ash Resource
  use Ash.Resource,
    # Tells Ash where the generated code interface belongs
    domain: OsmanthusPress.Blog,
    # Tells Ash to store this resource's data in Postgres
    data_layer: AshPostgres.DataLayer

  # The Postgres keyword is specific to the AshPostgres module
  postgres do
    # Tells Postgres what to call the table
    table "posts"
    # Tells Ash how to interface with the Postgres table
    repo OsmanthusPress.Repo
  end

  actions do
    # Exposes the default built in actions to manage the resource
    defaults [:read, :destroy]

    create :create do
      # Accepts title as input
      accept [:title]
    end

    update :update do
      # Accept content as input
      accept [:content]
    end

    # Defines custom read action which fetches post by id.
    read :by_id do
      # This action has one argument :id of type :uuid
      argument :id, :uuid, allow_nil?: false
      # Tells where to expect this action to return a single result
      get? true
      # Filters the `:id` given in the argument
      # against the `id` of each element in the resource
      filter expr(id == ^arg(:id))
    end
  end

  # Attributes are simple pieces of data that exists in the resource
  attributes do
    # Add an autogenerated UUID primary key called `:id`.
    uuid_primary_key :id
    # Add a string type attribute called `:title`.
    attribute :title, :string do
      # The tititle should never be `nil`
      allow_nil? false
    end

    # Add a string type attribute called `:content`
    # If allow_nil? is not specified, then content can be nil
    attribute :content, :string
  end
end
