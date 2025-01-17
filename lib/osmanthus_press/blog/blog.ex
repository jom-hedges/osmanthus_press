defmodule OsmanthusPress.Blog do
  use Ash.Domain
  use Ash.Api

  resources do
    resource OsmanthusPress.Blog.Post do
      # Defines an interface for calling resource actions
      define :create_post, action: :create
      define :list_posts, action: :read
      define :update_post, action: :update
      define :destroy_post, action: :destroy
      define :get_post, args: [:id], action: :by_id
    end

    registry OsmanthusPress.registry
  end
end
