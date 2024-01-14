defmodule Personal.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      PersonalWeb.Telemetry,
      Personal.Repo,
      {DNSCluster, query: Application.get_env(:personal, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Personal.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Personal.Finch},
      # Start a worker by calling: Personal.Worker.start_link(arg)
      # {Personal.Worker, arg},
      # Start to serve requests, typically the last entry
      PersonalWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Personal.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    PersonalWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
