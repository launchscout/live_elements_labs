defmodule LiveElementsLabs.ColorTopic do
  use LiveElementsLabs.GenericTopic, default_topic: "colors"

  def broadcast_color_change(new_color) do
    broadcast({:new_color, new_color}, default_topic())
  end
end
