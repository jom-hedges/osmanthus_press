defmodule OsmanthusPress.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      OsmanthusPressWeb.Telemetry,
      OsmanthusPress.Repo,
      {DNSCluster, query: Application.get_env(:osmanthus_press, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: OsmanthusPress.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: OsmanthusPress.Finch},
      # Start AshAuthentication Supervisor
      {AshAuthentication.Supervisor, otp_app: :osmanthus_press},
      # Start a worker by calling: OsmanthusPress.Worker.start_link(arg)
      # {OsmanthusPress.Worker, arg},
      # Start to serve requests, typically the last entry
      OsmanthusPressWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: OsmanthusPress.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    OsmanthusPressWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
