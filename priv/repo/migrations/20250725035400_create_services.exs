defmodule Recheck.Repo.Migrations.CreateServices do
  use Ecto.Migration

  def change do
    create table(:services) do
      add :name, :string
      add :description, :text

      timestamps(type: :utc_datetime)
    end

    create unique_index(:services, [:name])
  end
end
