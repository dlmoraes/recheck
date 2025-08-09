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
  end

  def office_fixture(attrs \\ %{}) do
    {:ok, office} =
      attrs
      |> valid_office_attributes()
      |> Recheck.Offices.create_office()

    office
  end
end
