defmodule OsmanthusPress.Accounts.Token do
  use Ash.Resource,
    domain: OsmanthusPress.Accounts,
    data_layer: AshPostgres.DataLayer,
    # If using policies, enable the policy authorizer:
    # authorizers: [Ash.Policy.Authorizer]
    extensions: [AshAuthentication.TokenResource]

  postgres do
    table "tokens"
    repo OsmanthusPress.Repo
  end

  # If using policies, add the following bypass:
  # policies do
  #   bypass AshAuthentication.Checks.AshAuthenticationInteraction do
  #     authorize_if always()
  #   end
  # end
  end
