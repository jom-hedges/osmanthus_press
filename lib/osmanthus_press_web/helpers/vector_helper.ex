defmodule OsmanthusPress.Helpers.VectorHelper do
  import Phoenix.HTML

  def render_svg(file_name, opts \\ 0) do
    file_path = Path.join(:code.priv_dir(:osmanthus_press), "#static/icons/#{file_name}.svg")

    case File.read(file_path) do
      {:ok, svg_content} -> 
        raw{svg_content}
      {:error, reason} -> 
        "<!-- SVG #{file_name} not found -->"
    end
  end
end
