defmodule LiveElementsLabsWeb.HelloLive do
  use LiveElementsLabsWeb, :live_view

  @greetings %{
    "French" => "Bonjour",
    "German" => "Wie geht's",
    "English" => "Hello",
    "Japanese" => "Konichiwa",
    "Spanish" => "Hola"
  }

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket |> assign(:greeting, "Hello") |> assign(:greetings, @greetings)}
  end

  @impl true
  def handle_event("change-language", %{"language" => language}, socket) do
    {:noreply, socket |> assign(:greeting, Map.get(@greetings, language))}
  end
end
