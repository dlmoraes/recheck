defmodule Recheck.CompaniesTest do
  use Recheck.DataCase

  import Recheck.CompaniesFixtures

  alias Recheck.Companies
  alias Recheck.Accounts.Company

  describe "companies" do
    test "list_companies/0 returns all companies" do
      company = company_fixture()
      assert Companies.list_companies() == [company]
    end

    test "get_company!/1 returns the company with given id" do
      company = company_fixture()
      assert Companies.get_company!(company.id) == company
    end

    test "create_company/1 with valid data creates a company" do
      attrs = valid_company_attributes()
      assert {:ok, %Company{} = company} = Companies.create_company(attrs)

      assert company.name == attrs.name
    end

    test "update_company/2 with valid data updates a company" do
      company = company_fixture()
      attrs = valid_company_attributes()
      assert {:ok, %Company{} = company} = Companies.update_company(company, attrs)
      assert company.name == attrs.name
    end

    test "delete_company/1 with valid data deletes a company" do
      company = company_fixture()
      assert {:ok, %Company{}} = Companies.delete_company(company)
      assert_raise Ecto.NoResultsError, fn -> Companies.get_company!(company.id) end
    end

    test "create_company/1 with invalid name uniqueness fails" do
      company1 = company_fixture()

      assert {:error, %Ecto.Changeset{} = changeset} =
               Companies.create_company(%{name: company1.name})

      assert changeset.valid? == false
      assert Keyword.keys(changeset.errors) == [:name]
      assert %{name: ["Já existe uma empresa com este nome."]} = errors_on(changeset)
    end

    test "create company/1 with requires name" do
      assert {:error, %Ecto.Changeset{} = changeset} =
               Companies.create_company(%{})

      assert changeset.valid? == false
      assert Keyword.keys(changeset.errors) == [:name]
      assert %{name: ["can't be blank"]} = errors_on(changeset)
    end

    test "update company/2 with requires name" do
      company = company_fixture()

      attrs =
        valid_company_attributes()
        |> Map.put(:name, nil)

      assert {:error, %Ecto.Changeset{} = changeset} =
               Companies.update_company(company, attrs)

      assert changeset.valid? == false
      assert Keyword.keys(changeset.errors) == [:name]
      assert %{name: ["can't be blank"]} = errors_on(changeset)
    end
  end
end
