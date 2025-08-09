defmodule Recheck.Operations.Service do
  use Ecto.Schema
  import Ecto.Changeset

  schema "services" do
    field :name, :string
    field :description, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(service, attrs) do
    service
    |> cast(attrs, [:name, :description])
    |> validate_required([:name, :description])
    |> validate_length(:name, min: 4, max: 60)
    |> validate_length(:description, max: 250)
    |> unique_constraint(:name,
      name: :services_company_id_name_index,
      message: "Já existe um serviço com este nome para essa empresa."
    )
  end
end
