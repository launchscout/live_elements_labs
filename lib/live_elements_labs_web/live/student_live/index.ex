defmodule LiveElementsLabsWeb.StudentLive.Index do
  use LiveElementsLabsWeb, :live_view

  alias LiveElementsLabs.Students
  alias LiveElementsLabs.Students.Student

  use LiveElements.CustomElementsHelpers
  custom_element(:bx_data_table, events: ["bx-table-header-cell-sort"])
  custom_element(:bx_pagination, events: ["bx-pagination-changed-current"])

  @default_sort [asc: :last_name]

  @impl true
  def mount(_params, _session, socket) do
    {count, students} = Students.paginate_students(order_by: @default_sort, limit: 10, offset: 0)

    {:ok,
     socket
     |> assign(%{
       students: students,
       student_count: count,
       sort: @default_sort,
       offset: 0
     })}
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
  def handle_info(
        {LiveElementsLabsWeb.StudentLive.FormComponent, {:saved, _student}},
        %{assigns: %{sort: sort, offset: offset}} = socket
      ) do
    {count, students} = Students.paginate_students(order_by: sort, limit: 10, offset: offset)

    {:noreply, socket |> assign(%{students: students, student_count: count})}
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
        %{assigns: %{offset: offset}} = socket
      ) do
    sort = build_sort(column, direction)
    {count, students} = Students.paginate_students(order_by: sort, limit: 10, offset: offset)
    {:noreply, socket |> assign(%{students: students, student_count: count, sort: sort})}
  end

  def handle_event(
        "bx-pagination-changed-current",
        %{"start" => offset},
        %{assigns: %{sort: sort}} = socket
      ) do
    {count, students} = Students.paginate_students(order_by: sort, limit: 10, offset: offset)
    {:noreply, socket |> assign(%{students: students, student_count: count, offset: offset})}
  end

  defp build_sort(column, "ascending"), do: [asc: String.to_existing_atom(column)]
  defp build_sort(column, "descending"), do: [desc: String.to_existing_atom(column)]
  defp build_sort(_column, "none"), do: nil

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
