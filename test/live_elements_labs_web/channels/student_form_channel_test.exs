defmodule LiveElementsLabsWeb.StudentFormChannelTest do
  alias LiveElementsLabs.Students.Student
  use LiveElementsLabsWeb.ChannelCase

  alias LiveElementsLabs.Students

  setup do
    {:ok, _, socket} =
      LiveElementsLabsWeb.UserSocket
      |> socket("user_id", %{some: :assign})
      |> subscribe_and_join(LiveElementsLabsWeb.StudentFormChannel, "student_form")

    %{socket: socket}
  end

  test "register event", %{socket: socket} do
    send_event(socket, "register", %{
      "email" => "bob@example.com",
      "first_name" => "Bob",
      "last_name" => "Smith",
      "experience_level" => "intermediate"
    })
    assert_state %{status: :complete}
    assert [%Student{email: "bob@example.com"}] = Students.list_students()
  end

  defp send_event(socket, event, payload) do
    push(socket, "lvs_evt:" <> event, payload)
  end

  defp assert_state(state) do
    assert_push "state:change", %{state: ^state}
  end
end
