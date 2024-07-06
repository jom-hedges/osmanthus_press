defmodule OsmanthusPress.Repo do
  use AshPostgres.Repo, otp_app: :osmanthus_press

  # installs commonly used extensions by Ash
  def installed_extensions do
    ["ash-functions", "uuid-ossp", "citext"]
  end
end
