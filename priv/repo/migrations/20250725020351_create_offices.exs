defmodule Recheck.Repo.Migrations.CreateOffices do
  use Ecto.Migration

  def change do
    create table(:offices) do
      add :name, :string
      add :company_id, references(:companies, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:offices, [:company_id])

    create unique_index(:offices, [:company_id, :name])
  end
end
