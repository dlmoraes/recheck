defmodule Recheck.Offices do
  import Ecto.Query, warn: false
  alias Recheck.Repo

  alias Recheck.Accounts.Office

  def create_office(attrs \\ %{}) do
    %Office{}
    |> Office.changeset(attrs)
    |> Repo.insert()
  end

  def get_office!(id), do: Repo.get!(Office, id)

  def list_offices do
    Repo.all(Office)
  end

  def update_office(%Office{} = office, attrs) do
    office
    |> Office.changeset(attrs)
    |> Repo.update()
  end

  def delete_office(%Office{} = office) do
    Repo.delete(office)
  end

  def list_unique_offices do
    Repo.all(from o in Office, select: o.name, distinct: true)
  end

  @spec options_for_select() :: list()
  def options_for_select do
    list_offices()
    |> Enum.map(fn office ->
      {office.name, office.id}
    end)
  end
end
