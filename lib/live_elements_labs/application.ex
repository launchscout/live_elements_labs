defmodule LiveElementsLabs.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      LiveElementsLabsWeb.Telemetry,
      # Start the Ecto repository
      LiveElementsLabs.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: LiveElementsLabs.PubSub},
      # Start Finch
      {Finch, name: LiveElementsLabs.Finch},
      # Start the Endpoint (http/https)
      LiveElementsLabsWeb.Endpoint,
      LiveElementsLabs.ChatBotConsumer
      # Start a worker by calling: LiveElementsLabs.Worker.start_link(arg)
      # {LiveElementsLabs.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: LiveElementsLabs.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    LiveElementsLabsWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
