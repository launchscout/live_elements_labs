defmodule LiveElementsLabs.Students.Student do
  use Ecto.Schema
  import Ecto.Changeset

  schema "students" do
    field :email, :string
    field :first_name, :string
    field :last_name, :string
    field :experience_level, Ecto.Enum, values: [:beginner, :intermediate, :expert]

    timestamps()
  end

  @doc false
  def changeset(student, attrs) do
    student
    |> cast(attrs, [:first_name, :last_name, :email])
    |> validate_required([:first_name, :last_name, :email])
  end
end
