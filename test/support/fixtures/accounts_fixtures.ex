defmodule Recheck.AccountsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Recheck.Accounts` context.
  """

  def unique_user_email, do: "user#{System.unique_integer()}@example.com"
  def valid_user_password, do: "hello world!"

  def valid_user_attributes(attrs \\ %{}) do
    Enum.into(attrs, %{
      email: unique_user_email(),
      password: valid_user_password()
    })
    |> add_company_if_necessary()
    |> add_office_if_necessary()
  end

  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> valid_user_attributes()
      |> Recheck.Accounts.register_user()

    user
  end

  def extract_user_token(fun) do
    {:ok, captured_email} = fun.(&"[TOKEN]#{&1}[TOKEN]")
    [_, token | _] = String.split(captured_email.text_body, "[TOKEN]")
    token
  end

  def add_company_if_necessary(attrs, key \\ :company_id) when is_map(attrs) do
    Map.put_new_lazy(attrs, key, fn ->
      company = Recheck.CompaniesFixtures.company_fixture()
      company.id
    end)
  end

  def add_office_if_necessary(attrs, key \\ :office_id) when is_map(attrs) do
    Map.put_new_lazy(attrs, key, fn ->
      office = Recheck.OfficesFixtures.office_fixture()
      office.id
    end)
  end
end
