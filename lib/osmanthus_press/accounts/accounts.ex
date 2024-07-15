defmodule OsmanthusPress.Accounts do
  use Ash.Domain

  resources do
    resource OsmanthusPress.Accounts.User
    resource OsmanthusPress.Accounts.Token
  end
end
