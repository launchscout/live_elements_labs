defmodule LiveElementsLabsWeb.ReactDemoLive do
  use LiveElementsLabsWeb, :live_view

  @colors ["red", "blue", "green", "purple"]

  @impl true
  def mount(_params, _session, socket) do
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
end
