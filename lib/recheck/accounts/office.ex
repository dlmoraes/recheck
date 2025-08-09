defmodule Recheck.Accounts.Office do
  use Ecto.Schema
  import Ecto.Changeset

  alias Recheck.Accounts.Company

  schema "offices" do
    field :name, :string
    belongs_to :company, Company

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(office, attrs) do
    office
    |> cast(attrs, [:name, :company_id])
    |> validate_required([:name, :company_id])
    |> validate_length(:name, min: 4, max: 80)
    |> assoc_constraint(:company)
    |> unique_constraint(:name,
      name: :offices_company_id_name_index,
      message: "Já existe um escritório com este nome para esa empresa."
    )
  end
end
