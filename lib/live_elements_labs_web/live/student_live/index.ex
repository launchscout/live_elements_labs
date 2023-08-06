defmodule LiveElementsLabsWeb.StudentLive.Index do
  use LiveElementsLabsWeb, :live_view

  alias LiveElementsLabs.Students
  alias LiveElementsLabs.Students.Student

  use LiveElements.CustomElementsHelpers
  custom_element(:bx_data_table, events: ["bx-table-header-cell-sort"])

  @default_sort [asc: :last_name]

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket |> assign(:students, Students.list_students()) |> assign(:sort, @default_sort)}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Student")
    |> assign(:student, Students.get_student!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Student")
    |> assign(:student, %Student{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Students")
    |> assign(:student, nil)
  end

  @impl true
  def handle_info({LiveElementsLabsWeb.StudentLive.FormComponent, {:saved, student}}, socket) do
    {:noreply, assign(socket, :students, Students.list_students())}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    student = Students.get_student!(id)
    {:ok, _} = Students.delete_student(student)

    {:noreply, assign(socket, :students, Students.list_students())}
  end

  def handle_event(
        "bx-table-header-cell-sort",
        %{
          "columnId" => column,
          "sortDirection" => direction
        },
        socket
      ) do
    sort = build_sort(column, direction)
    {:noreply, socket |> assign(:sort, sort) |> assign(:students, Students.list_students(sort))}
  end

  defp build_sort(column, "ascending"), do: [asc: String.to_existing_atom(column)]
  defp build_sort(column, "descending"), do: [desc: String.to_existing_atom(column)]
  defp build_sort(column, "none"), do: nil

  def sort_direction(column, asc: sort_column) do
    if String.to_existing_atom(column) == sort_column do
      "ascending"
    else
      "none"
    end
  end

  def sort_direction(column, desc: sort_column) do
    if String.to_existing_atom(column) == sort_column do
      "descending"
    else
      "none"
    end
  end

  def sort_direction(_, _), do: "none"
end
