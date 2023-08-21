defmodule LiveElementsLabsWeb.StudentFormChannel do
  use LiveState.Channel, web_module: LiveElementsLabsWeb

  alias LiveElementsLabs.Students

  @impl true
  def init(_channel, _payload, _socket) do
    {:ok, %{}}
  end

  @impl true
  def handle_event("register", student_attrs, state) do
    case Students.create_student(student_attrs) do
      {:ok, _student} -> {:noreply, Map.put(state, :status, :complete)}
      {:error, _} -> state
    end
  end
end
