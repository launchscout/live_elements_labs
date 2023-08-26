defmodule LiveElementsLabsWeb.HelloChannel do

  use LiveState.Channel, web_module: LiveElementsLabsWeb

  @greetings %{
    "French" => "Bonjour",
    "German" => "Wie geht's",
    "English" => "Hello"
  }

  @impl true
  def init(_params, _session, _socket) do
    {:ok, %{greeting: "hello"}}
  end

  @impl true
  def handle_event("change-language", %{"language" => language}, state) do
    {:noreply, Map.put(state, :greeting, Map.get(@greetings, language))}
  end
end
