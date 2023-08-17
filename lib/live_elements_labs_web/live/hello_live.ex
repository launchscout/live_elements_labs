defmodule LiveElementsLabsWeb.HelloLive do
  use LiveElementsLabsWeb, :live_view

  use LiveElements.CustomElementsHelpers

  custom_element :hello_world, events: ["change-language"]

  @greetings %{
    "French" => "Bonjour",
    "German" => "Wie geht's",
    "English" => "Hello"
  }

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket |> assign(:greeting, "Hello")}
  end

  @impl true
  def handle_event("change-language", %{"language" => language}, socket) do
    {:noreply, socket |> assign(:greeting, Map.get(@greetings, language))}
  end
end
