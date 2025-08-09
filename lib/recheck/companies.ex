defmodule Recheck.Companies do
  import Ecto.Query, warn: false
  alias Recheck.Repo

  alias Recheck.Accounts.Company

  def create_company(attrs \\ %{}) do
    %Company{}
    |> Company.changeset(attrs)
    |> Repo.insert()
  end

  def get_company!(id), do: Repo.get!(Company, id)

  def list_companies do
    Repo.all(Company)
  end

  def update_company(%Company{} = company, attrs) do
    company
    |> Company.changeset(attrs)
    |> Repo.update()
  end

  def delete_company(%Company{} = company) do
    Repo.delete(company)
  end

  def list_unique_companies do
    Repo.all(from c in Company, select: c.name, distinct: true)
  end

  @spec options_for_select() :: list()
  def options_for_select do
    list_companies()
    |> Enum.map(fn company ->
      {company.name, company.id}
    end)
  end
end
