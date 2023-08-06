defmodule LiveElementsLabs.Repo.Migrations.CreateStudents do
  use Ecto.Migration

  def change do
    create table(:students) do
      add :first_name, :string
      add :last_name, :string
      add :email, :string

      timestamps()
    end
  end
end
