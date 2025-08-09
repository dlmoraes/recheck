defmodule Recheck.Feedback.Feedback do
  use Ecto.Schema
  import Ecto.Changeset

  alias Recheck.Accounts.{User, Company}
  alias Recheck.Operations.Service

  @statuses [:AT, :CA, :CO]

  schema "feedback" do
    field :source_request_id, :string
    field :error_details, :string
    field :correct_procedure, :string
    field :deadline, :date
    field :attachments, {:array, :string}, default: []
    field :status, Ecto.Enum, values: @statuses, default: :AT

    belongs_to :creator, User, foreign_key: :creator_id
    belongs_to :recipient, User, foreign_key: :recipient_id
    belongs_to :company, Company
    belongs_to :service, Service

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(feedback, attrs) do
    feedback
    |> cast(attrs, [
      :source_request_id,
      :error_details,
      :correct_procedure,
      :creator_id,
      :recipient_id,
      :company_id,
      :service_id
    ])
    |> validate_required([
      :source_request_id,
      :error_details,
      :correct_procedure,
      :creator_id,
      :recipient_id,
      :company_id,
      :service_id
    ])
    |> assoc_constraint(:creator)
    |> assoc_constraint(:recipient)
    |> assoc_constraint(:company)
    |> assoc_constraint(:service)
    |> put_default_status()
    |> put_deadline()
    |> validate_length(:attachments, max: 3, message: "é permitido no máximo 3 anexos")
  end

  defp put_deadline(changeset) do
    if changeset.action == :insert do
      deadline = Date.add(Date.utc_today(), 7)
      put_change(changeset, :deadline, deadline)
    else
      changeset
    end
  end

  defp put_default_status(changeset) do
    case get_field(changeset, :status) do
      nil -> put_change(changeset, :status, :AT)
      _ -> changeset
    end
  end
end
