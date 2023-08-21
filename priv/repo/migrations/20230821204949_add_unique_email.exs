defmodule LiveElementsLabs.Repo.Migrations.AddUniqueEmail do
  use Ecto.Migration

  def change do
    create unique_index(:students, [:email])
  end
end
