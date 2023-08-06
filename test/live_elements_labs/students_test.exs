defmodule LiveElementsLabs.StudentsTest do
  use LiveElementsLabs.DataCase

  alias LiveElementsLabs.Students

  describe "students" do
    alias LiveElementsLabs.Students.Student

    import LiveElementsLabs.StudentsFixtures

    @invalid_attrs %{email: nil, first_name: nil, last_name: nil}

    test "list_students/0 returns all students" do
      student = student_fixture()
      assert Students.list_students() == [student]
    end

    test "list_students/1 sorts students" do
      student1 = student_fixture(%{last_name: "Zeta"})
      student2 = student_fixture(%{last_name: "Allen"})
      student3 = student_fixture(%{last_name: "Pope"})

      assert Students.list_students([asc: :last_name]) |> Enum.map(& &1.id) == [
               student2.id,
               student3.id,
               student1.id
             ]
    end

    test "get_student!/1 returns the student with given id" do
      student = student_fixture()
      assert Students.get_student!(student.id) == student
    end

    test "create_student/1 with valid data creates a student" do
      valid_attrs = %{
        email: "some email",
        first_name: "some first_name",
        last_name: "some last_name"
      }

      assert {:ok, %Student{} = student} = Students.create_student(valid_attrs)
      assert student.email == "some email"
      assert student.first_name == "some first_name"
      assert student.last_name == "some last_name"
    end

    test "create_student/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Students.create_student(@invalid_attrs)
    end

    test "update_student/2 with valid data updates the student" do
      student = student_fixture()

      update_attrs = %{
        email: "some updated email",
        first_name: "some updated first_name",
        last_name: "some updated last_name"
      }

      assert {:ok, %Student{} = student} = Students.update_student(student, update_attrs)
      assert student.email == "some updated email"
      assert student.first_name == "some updated first_name"
      assert student.last_name == "some updated last_name"
    end

    test "update_student/2 with invalid data returns error changeset" do
      student = student_fixture()
      assert {:error, %Ecto.Changeset{}} = Students.update_student(student, @invalid_attrs)
      assert student == Students.get_student!(student.id)
    end

    test "delete_student/1 deletes the student" do
      student = student_fixture()
      assert {:ok, %Student{}} = Students.delete_student(student)
      assert_raise Ecto.NoResultsError, fn -> Students.get_student!(student.id) end
    end

    test "change_student/1 returns a student changeset" do
      student = student_fixture()
      assert %Ecto.Changeset{} = Students.change_student(student)
    end
  end
end
