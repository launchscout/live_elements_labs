defmodule LiveElementsLabsWeb.HelloLive do
  use LiveElementsLabsWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket |> assign(:greeting, "Hello")}
  end
end
