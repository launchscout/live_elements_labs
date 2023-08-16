defmodule LiveElementsLabs.Repo.Migrations.AddExperienceLevelToStudents do
  use Ecto.Migration

  def change do
    alter table(:students) do
      add :experience_level, :string
    end
  end
end
