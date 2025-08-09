defmodule Recheck.Accounts.Company do
  use Ecto.Schema
  import Ecto.Changeset

  schema "companies" do
    field :name, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(company, attrs) do
    company
    |> cast(attrs, [:name])
    |> validate_length(:name, min: 4, max: 80)
    |> validate_required([:name])
    |> unique_constraint(:name,
      name: :companies_name_index,
      message: "Já existe uma empresa com este nome."
    )
  end
end
