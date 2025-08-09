defmodule Recheck.CompaniesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Recheck.Companies` context.
  """

  def valid_company_name, do: "Company name #{System.unique_integer()}"

  def valid_company_attributes(attrs \\ %{}) do
    Enum.into(attrs, %{
      name: valid_company_name()
    })
  end

  def company_fixture(attrs \\ %{}) do
    {:ok, company} =
      attrs
      |> valid_company_attributes()
      |> Recheck.Companies.create_company()

    company
  end
end
