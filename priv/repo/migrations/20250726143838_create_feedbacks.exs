defmodule Recheck.Repo.Migrations.CreateFeedbacks do
  use Ecto.Migration

  def change do
    create table(:feedbacks) do
      add :source_request_id, :string, null: false
      add :error_details, :text
      add :correct_procedure, :text
      add :status, :string
      add :deadline, :date
      add :attachments, :map
      add :creator_id, references(:users, on_delete: :nothing)
      add :recipient_id, references(:users, on_delete: :nothing)
      add :company_id, references(:companies, on_delete: :nothing)
      add :service_id, references(:services, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:feedbacks, [:creator_id])
    create index(:feedbacks, [:recipient_id])
    create index(:feedbacks, [:company_id])
    create index(:feedbacks, [:service_id])
  end
end
