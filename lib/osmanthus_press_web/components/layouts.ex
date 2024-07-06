defmodule OsmanthusPressWeb.Layouts do
  @moduledoc """
  This module holds different layouts used by your application.

  See the `layouts` directory for all templates available.
  The "root" layout is a skeleton rendered as part of the
  application router. The "app" layout is set as the default
  layout on both `use OsmanthusPressWeb, :controller` and
  `use OsmanthusPressWeb, :live_view`.
  """
  use OsmanthusPressWeb, :html

  embed_templates "layouts/*"
end
