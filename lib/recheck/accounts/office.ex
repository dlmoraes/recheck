defmodule Recheck.Accounts.Office do
  use Ecto.Schema
  import Ecto.Changeset

  schema "offices" do
    field :name, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(office, attrs) do
    office
    |> cast(attrs, [:name])
    |> validate_required([:name])
    |> validate_length(:name, min: 4, max: 80)
    |> unique_constraint(:name,
      name: :offices_name_index,
      message: "Já existe um escritório com este nome."
    )
  end
end
