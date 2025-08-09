defmodule Recheck.ServicesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Recheck.Services` context.
  """

  def valid_service_name, do: "Service name #{System.unique_integer()}"
  def valid_service_description, do: "Service Description #{System.unique_integer()}"

  def valid_service_attributes(attrs \\ %{}) do
    Enum.into(attrs, %{
      name: valid_service_name(),
      description: valid_service_description()
    })
    |> add_company_if_necessary()
  end

  def service_fixture(attrs \\ %{}) do
    {:ok, service} =
      attrs
      |> valid_service_attributes()
      |> Recheck.Services.create_service()

    service
  end

  def add_company_if_necessary(attrs, key \\ :company_id) when is_map(attrs) do
    Map.put_new_lazy(attrs, key, fn ->
      company = Recheck.CompaniesFixtures.company_fixture()
      company.id
    end)
  end
end
