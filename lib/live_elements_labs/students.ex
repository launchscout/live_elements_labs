defmodule LiveElementsLabs.Students do
  @moduledoc """
  The Students context.
  """

  import Ecto.Query, warn: false
  alias LiveElementsLabs.Repo

  alias LiveElementsLabs.Students.Student

  @doc """
  Returns the list of students.

  ## Examples

      iex> list_students()
      [%Student{}, ...]

  """
  def list_students do
    Repo.all(Student)
  end

  def list_students(sort) do
    from(s in Student, order_by: ^sort) |> Repo.all()
  end

  def paginate_students(order_by: order_by, limit: limit, offset: offset) do
    count = Repo.aggregate(Student, :count)

    students =
      from(s in Student, order_by: ^order_by, limit: ^limit, offset: ^offset) |> Repo.all()

    {count, students}
  end

  def experience_levels() do
    query =
      from s in Student, group_by: s.experience_level, select: {s.experience_level, count(s.id)}

    Repo.all(query) |> Enum.into(%{})
  end

  def form_fields() do
    Student.__schema__(:fields)
    |> Enum.filter(&editable_field?/1)
    |> Enum.map(&form_field/1)
  end

  defp editable_field?(field) do
    !(field in [:id, :inserted_at, :updated_at])
  end

  defp form_field(field) do
    case Student.__schema__(:type, field) do
      {:parameterized, Ecto.Enum, %{mappings: mappings}} ->
        %{name: field, type: "select", values: Keyword.keys(mappings)}
      type -> %{name: field, type: type}
    end
  end

  @doc """
  Gets a single student.

  Raises `Ecto.NoResultsError` if the Student does not exist.

  ## Examples

      iex> get_student!(123)
      %Student{}

      iex> get_student!(456)
      ** (Ecto.NoResultsError)

  """
  def get_student!(id), do: Repo.get!(Student, id)

  @doc """
  Creates a student.

  ## Examples

      iex> create_student(%{field: value})
      {:ok, %Student{}}

      iex> create_student(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_student(attrs \\ %{}) do
    %Student{}
    |> Student.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a student.

  ## Examples

      iex> update_student(student, %{field: new_value})
      {:ok, %Student{}}

      iex> update_student(student, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_student(%Student{} = student, attrs) do
    student
    |> Student.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a student.

  ## Examples

      iex> delete_student(student)
      {:ok, %Student{}}

      iex> delete_student(student)
      {:error, %Ecto.Changeset{}}

  """
  def delete_student(%Student{} = student) do
    Repo.delete(student)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking student changes.

  ## Examples

      iex> change_student(student)
      %Ecto.Changeset{data: %Student{}}

  """
  def change_student(%Student{} = student, attrs \\ %{}) do
    Student.changeset(student, attrs)
  end
end
