defmodule Recheck.OfficesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Recheck.Offices` context.
  """

  def valid_office_name, do: "Office name #{System.unique_integer()}"

  def valid_office_attributes(attrs \\ %{}) do
    Enum.into(attrs, %{
      name: valid_office_name()
    })
    |> add_company_if_necessary()
  end

  def office_fixture(attrs \\ %{}) do
    {:ok, office} =
      attrs
      |> valid_office_attributes()
      |> Recheck.Offices.create_office()

    office
  end

  def add_company_if_necessary(attrs, key \\ :company_id) when is_map(attrs) do
    Map.put_new_lazy(attrs, key, fn ->
      company = Recheck.CompaniesFixtures.company_fixture()
      company.id
    end)
  end
end
