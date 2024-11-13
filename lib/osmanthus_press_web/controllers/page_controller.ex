defmodule OsmanthusPressWeb.PageController do
  use OsmanthusPressWeb, :controller

  def home(conn, _params) do
    # The home page is often custom made,
    # so skip the default app layout.
    render(conn, :home, layout: false)
  end

  def catalogue(conn, _params) do
    render(conn, :catalogue, layout: false)
  end
end
