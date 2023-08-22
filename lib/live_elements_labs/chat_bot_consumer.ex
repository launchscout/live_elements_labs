defmodule LiveElementsLabs.ChatBotConsumer do
  use Nostrum.Consumer

  alias Phoenix.PubSub

  def bot_id do
    Application.get_env(:live_elements_labs, :bot_id)
  end

  def start_link do
    Consumer.start_link(__MODULE__)
  end

  def handle_event({:MESSAGE_CREATE, %{channel_id: channel_id, content: content, author: %{username: username, id: id}}, _ws_state}) do
    from = (if id == bot_id(), do: "you", else: username)
    PubSub.broadcast!(LiveElementsLabs.PubSub, "messages:#{channel_id}", {:message_created, from, content})
  end

  # Default event handler, if you don't include this, your consumer WILL crash if
  # you don't have a method definition for each event type.
  def handle_event(_event) do
    :noop
  end
end
