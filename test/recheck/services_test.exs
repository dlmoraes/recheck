defmodule Recheck.ServicesTest do
  alias Recheck.ServicesFixtures
  use Recheck.DataCase

  alias Recheck.Services
  alias Recheck.Operations.Service

  describe "services" do
    test "list_services/0 returns all services" do
      service = ServicesFixtures.service_fixture()
      assert Services.list_services() == [service]
    end

    test "get_service!/1 returns the service with given id" do
      service = ServicesFixtures.service_fixture()
      assert Services.get_service!(service.id) == service
    end

    test "create_service/1 with valid data creates a service" do
      attrs = ServicesFixtures.valid_service_attributes()
      assert {:ok, %Service{} = service} = Services.create_service(attrs)
      assert service.name == attrs.name
      assert service.description == attrs.description
    end

    test "create_service/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Services.create_service(%{})
    end

    test "create_service/1 with requires name" do
      attrs =
        ServicesFixtures.valid_service_attributes()
        |> Map.put(:name, nil)

      assert {:error, %Ecto.Changeset{} = changeset} =
               Services.create_service(attrs)

      assert changeset.valid? == false
      assert Keyword.keys(changeset.errors) == [:name]
      assert %{name: ["can't be blank"]} = errors_on(changeset)
    end

    test "create_service/1 with requires description" do
      attrs =
        ServicesFixtures.valid_service_attributes()
        |> Map.put(:description, nil)

      assert {:error, %Ecto.Changeset{} = changeset} =
               Services.create_service(attrs)

      assert changeset.valid? == false
      assert Keyword.keys(changeset.errors) == [:description]
      assert %{description: ["can't be blank"]} = errors_on(changeset)
    end

    test "update_service/2 with valid data updates the service" do
      service = ServicesFixtures.service_fixture()
      update_attrs = ServicesFixtures.valid_service_attributes()
      assert {:ok, %Service{} = service} = Services.update_service(service, update_attrs)
      assert service.name == update_attrs.name
      assert service.description == update_attrs.description
    end

    test "update_service/2 with invalid data returns error changeset" do
      service = ServicesFixtures.service_fixture()

      assert {:error, %Ecto.Changeset{}} =
               Services.update_service(service, %{
                 name: nil
               })

      assert {:error, %Ecto.Changeset{}} =
               Services.update_service(service, %{
                 description: nil
               })
    end

    test "delete_service/1 deletes the service" do
      service = ServicesFixtures.service_fixture()
      assert {:ok, %Service{}} = Services.delete_service(service)
      assert_raise Ecto.NoResultsError, fn -> Services.get_service!(service.id) end
    end
  end
end
