defmodule Recheck.Operations.Service do
  use Ecto.Schema
  import Ecto.Changeset

  alias Recheck.Accounts.Company

  schema "services" do
    field :name, :string
    field :description, :string
    belongs_to :company, Company

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(service, attrs) do
    service
    |> cast(attrs, [:name, :description, :company_id])
    |> validate_required([:name, :description, :company_id])
    |> validate_length(:name, min: 4, max: 50)
    |> validate_length(:description, max: 250)
    |> assoc_constraint(:company)
    |> unique_constraint(:name,
      name: :services_company_id_name_index,
      message: "Já existe um serviço com este nome para essa empresa."
    )
  end
end
