defmodule OsmanthusPress.PostController do
  use OsmanthusPressWeb, :controller
  alias OsmanthusPress.Blog.Blog
  alias OsmanthusPress.Blog.Post
  alias OsmanthusPressWeb.Router.Helpers, as: Routes

  def index(conn, _params) do
    posts = Blog.read!(Post)
    render(conn, "index.html", posts: posts)
  end

  def show(conn, %{"id" => id}) do
    post = Blog.get!(Post, id)
    render(conn, "show.html", post: post)
  end

  def new(conn, _params) do
    changeset = Post.changeset(%Post{})
    render(conn, "show.html", changeset: changeset)
  end

  def create_post(conn, %{"post" => post_params}) do
    case Blog.create!(Post, post_params) do
      {:ok, post} -> 
        redirect(conn, to: Routes.post_path(conn, :show, post))
      {:error, changeset} -> 
        render(conn, "new.html", changeset: changeset)
    end
  end
end
