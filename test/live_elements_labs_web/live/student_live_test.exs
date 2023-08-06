defmodule LiveElementsLabsWeb.StudentLiveTest do
  use LiveElementsLabsWeb.ConnCase

  import Phoenix.LiveViewTest
  import LiveElementsLabs.StudentsFixtures

  @create_attrs %{email: "some email", first_name: "some first_name", last_name: "some last_name"}
  @update_attrs %{email: "some updated email", first_name: "some updated first_name", last_name: "some updated last_name"}
  @invalid_attrs %{email: nil, first_name: nil, last_name: nil}

  defp create_student(_) do
    student = student_fixture()
    %{student: student}
  end

  describe "Index" do
    setup [:create_student]

    test "lists all students", %{conn: conn, student: student} do
      {:ok, _index_live, html} = live(conn, ~p"/students")

      assert html =~ "Listing Students"
      assert html =~ student.email
    end

    test "saves new student", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/students")

      assert index_live |> element("a", "New Student") |> render_click() =~
               "New Student"

      assert_patch(index_live, ~p"/students/new")

      assert index_live
             |> form("#student-form", student: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#student-form", student: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/students")

      html = render(index_live)
      assert html =~ "Student created successfully"
      assert html =~ "some email"
    end

    test "updates student in listing", %{conn: conn, student: student} do
      {:ok, index_live, _html} = live(conn, ~p"/students")

      assert index_live |> element("#students-#{student.id} a", "Edit") |> render_click() =~
               "Edit Student"

      assert_patch(index_live, ~p"/students/#{student}/edit")

      assert index_live
             |> form("#student-form", student: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#student-form", student: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/students")

      html = render(index_live)
      assert html =~ "Student updated successfully"
      assert html =~ "some updated email"
    end

    test "deletes student in listing", %{conn: conn, student: student} do
      {:ok, index_live, _html} = live(conn, ~p"/students")

      assert index_live |> element("#students-#{student.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#students-#{student.id}")
    end
  end

  describe "Show" do
    setup [:create_student]

    test "displays student", %{conn: conn, student: student} do
      {:ok, _show_live, html} = live(conn, ~p"/students/#{student}")

      assert html =~ "Show Student"
      assert html =~ student.email
    end

    test "updates student within modal", %{conn: conn, student: student} do
      {:ok, show_live, _html} = live(conn, ~p"/students/#{student}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Student"

      assert_patch(show_live, ~p"/students/#{student}/show/edit")

      assert show_live
             |> form("#student-form", student: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#student-form", student: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/students/#{student}")

      html = render(show_live)
      assert html =~ "Student updated successfully"
      assert html =~ "some updated email"
    end
  end
end
