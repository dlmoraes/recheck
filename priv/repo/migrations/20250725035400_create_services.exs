defmodule Recheck.Repo.Migrations.CreateServices do
  use Ecto.Migration

  def change do
    create table(:services) do
      add :name, :string
      add :description, :text
      add :company_id, references(:companies, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:services, [:company_id])

    create unique_index(:services, [:company_id, :name])
  end
end
