defmodule Recheck.OfficesTest do
  alias Recheck.OfficesFixtures
  use Recheck.DataCase

  alias Recheck.Offices
  alias Recheck.Accounts.Office

  describe "officies" do
    test "list_offices/0 returns all officies" do
      office = OfficesFixtures.office_fixture()
      assert Offices.list_offices() == [office]
    end

    test "get_office!/1 returns the office with given id" do
      office = OfficesFixtures.office_fixture()
      assert Offices.get_office!(office.id) == office
    end

    test "create_office/1 with valid data creates a office" do
      valid_attrs = OfficesFixtures.valid_office_attributes()
      assert {:ok, %Office{} = office} = Offices.create_office(valid_attrs)
      assert office.name == valid_attrs.name
    end

    test "create_office/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Offices.create_office(%{})
    end

    test "create_office/1 with requires name" do
      assert {:error, %Ecto.Changeset{} = changeset} =
               Offices.create_office(%{
                 name: nil
               })

      assert changeset.valid? == false
      assert Keyword.keys(changeset.errors) == [:name]
      assert %{name: ["can't be blank"]} = errors_on(changeset)
    end

    test "update_office/2 with valid data updates the office" do
      office = OfficesFixtures.office_fixture()
      update_attrs = OfficesFixtures.valid_office_attributes()
      assert {:ok, %Office{} = office} = Offices.update_office(office, update_attrs)
      assert office.name == update_attrs.name
    end

    test "update_office/2 with invalid data returns error changeset" do
      office = OfficesFixtures.office_fixture()

      assert {:error, %Ecto.Changeset{}} =
               Offices.update_office(office, %{
                 name: nil
               })
    end

    test "delete_office/1 deletes the office" do
      office = OfficesFixtures.office_fixture()
      assert {:ok, %Office{}} = Offices.delete_office(office)
      assert_raise Ecto.NoResultsError, fn -> Offices.get_office!(office.id) end
    end
  end
end
