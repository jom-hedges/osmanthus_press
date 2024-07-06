defmodule OsmanthusPress.Repo do
  use Ecto.Repo,
    otp_app: :osmanthus_press,
    adapter: Ecto.Adapters.Postgres
end
