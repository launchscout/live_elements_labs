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
      {:error, changeset} -> {:noreply, Map.put(state, :errors, errors_from(changeset))}
    end
  end

  defp errors_from(%Ecto.Changeset{errors: errors}) do
    errors |> Enum.map(fn {field, {message, _}} -> {field, message} end) |> Enum.into(%{})
  end
end
