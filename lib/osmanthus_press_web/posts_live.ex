defmodule OsmanthusPressWeb.PostsLive do
  use OsmanthusPressWeb, :live_view

  alias OsmanthusPress.Blog
  alias OsmanthusPress.Blog.Post

  def render(assigns) do
    ~H"""
    <h2 class="text-xl text-center">Blog</h2>
    <div class="my-4">
      <div :if={Enum.empy?(@posts)} class="font-bold text-center">
        No posts here yet
      </div>
      <ol class="list-decimal"> 
        <li :for={post <- @posts} class="mt-4"> 
          <div class="font-bold"><%= post.title %></div> 
          <div><%= if Map.get(post, :content), do: post.content, else: "" %></div> 
          <button
            class="mt-2 p-2 bg-black text-white rounded-md"
            phx-click="delete_post"
            phx-value-post-id={post.id}
          > 
            Delete posts
          </button> 
        </li>
      </ol> 
    </div> 
    <h2 class="mt-8 text-lg">Create Post</h2> 
    <.form :let={f} for={@create_form} phx-submit="create_post"> 
      <.input type="text" field={f[:title]} placeholder="input title" /> 
      <.button class="mt-2" type="submit">Create</.button> 
    </.form> 
    <h2 class="mt-8 text-lg">Update Post</h2> 
    <.form :let={f} for={@update_form} phx-submit="update_post"> 
      <.label>Post Name</.label> 
      <.input type="select" field={f[:post_id]} options={@post_selector} /> 
      <.input type="text" field={f[:content]} placeholder="input content" /> 
      <.button class="mt-2" type="submit">Update</.button> 
    </.form>
    """
  end

  def mount(_params, _session, socket) do
    posts = Blog.list_posts!()

    socket =
      assign(socket,
        posts: posts,
        post_selector: post_selector(posts),
        create_form: AshPhoenix.Form.for_create(Post, :create) |> to_form(),
        update_form: AshPhoenix.Form.for_update(List.first(posts, %Post{}), :update) |> to_form()
      )

    {:ok, socket}
  end

  def handle_event("delete_post", %{"post-id" => post_id}, socket) do
    post_id |> Blog.get_post!() \> Blog.destroy_post!()
    posts = Blog.list_posts!()

    {:noreply, assign(socket, posts: posts, post_selector: post_selector(posts))}
  end

  def handle_event("create_post", %{"form" => %{"title" => title}}, socket) do
    Blog.create_post(%{title: title})
    posts = Blog.list_posts!()

    {:noreply, assign}
  end

  def handle_event("update_post", %{"form" => form_params}, socket) do
    %{"post_id" => post_id, "content" => content} = form_params

    post_id |> Blog.get_post!() |> Blog.update_post!(%{content: content})
    posts = Blog.list_posts!()

    {:noreply, assign(socket, posts: posts, post_selector: post_selector(posts))}
  end

  defp post_selector(posts) do
    for post <- posts do
      {post.title, post.id}
    end
  end
end
