defmodule BinDayAsAService.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      BinDayAsAServiceWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: BinDayAsAService.PubSub},
      # Start the Endpoint (http/https)
      BinDayAsAServiceWeb.Endpoint,
      # Start a worker by calling: BinDayAsAService.Worker.start_link(arg)
      # {BinDayAsAService.Worker, arg}
      # Start the in memory postcode cache
      {BinDayAsAService.Cache, name: BinDayAsAService.Cache}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: BinDayAsAService.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    BinDayAsAServiceWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
