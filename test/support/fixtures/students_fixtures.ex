defmodule LiveElementsLabs.StudentsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `LiveElementsLabs.Students` context.
  """

  @doc """
  Generate a student.
  """
  def student_fixture(attrs \\ %{}) do
    {:ok, student} =
      attrs
      |> Enum.into(%{
        email: "some email",
        first_name: "some first_name",
        last_name: "some last_name",
        experience_level: "beginner"
      })
      |> LiveElementsLabs.Students.create_student()

    student
  end
end
