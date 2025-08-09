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
  end

  def service_fixture(attrs \\ %{}) do
    {:ok, service} =
      attrs
      |> valid_service_attributes()
      |> Recheck.Services.create_service()

    service
  end
end
