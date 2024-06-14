defmodule Foodtrunk.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      FoodtrunkWeb.Telemetry,
      Foodtrunk.Repo,
      {DNSCluster, query: Application.get_env(:foodtrunk, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Foodtrunk.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Foodtrunk.Finch},
      # Start a worker by calling: Foodtrunk.Worker.start_link(arg)
      # {Foodtrunk.Worker, arg},
      # Start to serve requests, typically the last entry
      FoodtrunkWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Foodtrunk.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    FoodtrunkWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
