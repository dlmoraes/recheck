defmodule Recheck.Factory do
  use ExMachina.Ecto, repo: Recheck.Repo

  alias Recheck.Accounts
  alias Recheck.Accounts.Office
  alias Recheck.Accounts.Company
  alias Recheck.Operations.Service

  def without_preloads(objects) when is_list(objects), do: Enum.map(objects, &without_preloads/1)
  def without_preloads(%Office{} = office), do: Ecto.reset_fields(office, [:company])
  def without_preloads(%Service{} = service), do: Ecto.reset_fields(service, [:company])

  def company_factory do
    %Company{
      name: sequence(:name, &"company-#{&1}")
    }
  end

  def user_factory do
    %Accounts.User{
      email: sequence(:email, &"email-#{&1}@example.com"),
      hashed_password: "_",
      company: build(:company),
      office: build(:office)
    }
  end

  def office_factory do
    %Office{
      name: sequence(:name, &"office-#{&1}")
    }
  end

  def service_factory do
    %Service{
      name: sequence(:name, &"service-#{&1}"),
      description: sequence(:description, &"description-#{&1}")
    }
  end
end
