defmodule LiveElementsLabsWeb.ReactDemoLive do
  use LiveElementsLabsWeb, :live_view

  alias LiveElementsLabs.ColorTopic

  @colors ["red", "blue", "green", "purple"]

  @impl true
  def mount(_params, _session, socket) do
    if connected?(socket) do
      ColorTopic.subscribe()
    end

    socket
    |> assign(:colors, @colors)
    |> assign(:current_color, List.first(@colors))
    |> then(&{:ok, &1})
  end

  @impl true
  def handle_event("change-color", %{"color" => color}, socket) do
    socket
    |> assign(:current_color, color)
    |> then(&{:noreply, &1})
  end

  @impl true
  def handle_info({:new_color, color}, socket) do
    socket
    |> assign(:current_color, color)
    |> then(&{:noreply, &1})
  end
end
