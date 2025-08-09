defmodule Recheck.Repo.Migrations.CreateOffices do
  use Ecto.Migration

  def change do
    create table(:offices) do
      add :name, :string

      timestamps(type: :utc_datetime)
    end

    create unique_index(:offices, [:name])
  end
end
