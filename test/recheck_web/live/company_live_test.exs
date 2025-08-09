defmodule RecheckWeb.CompanyLiveTest do
  use RecheckWeb.ConnCase, async: true

  import Phoenix.LiveViewTest
  alias Recheck.AccountsFixtures
  alias Recheck.CompaniesFixtures

  @create_attrs %{name: CompaniesFixtures.valid_company_name()}
  @update_attrs %{name: CompaniesFixtures.valid_company_name()}
  @invalid_attrs %{name: nil}

  defp create_company(%{conn: conn}) do
    company = CompaniesFixtures.company_fixture()
    user = AccountsFixtures.user_fixture()
    conn = log_in_user(conn, user)
    %{conn: conn, company: company, user: user}
  end

  describe "Index" do
    setup [:create_company]

    test "lists all companies", %{conn: conn, company: company} do
      {:ok, _index_live, html} = live(conn, ~p"/admin/companies")

      assert html =~ "Listing Companies"
      assert html =~ company.name
    end

    test "saves new company", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/admin/companies")

      assert index_live |> element("a", "New Company") |> render_click() =~
               "New Company"

      assert_patch(index_live, ~p"/admin/companies/new")

      assert index_live
             |> form("#company-form", company: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#company-form", company: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/admin/companies")

      html = render(index_live)
      assert html =~ "Company created successfully"
      assert html =~ @create_attrs.name
    end

    test "updates company in listing", %{conn: conn, company: company} do
      {:ok, index_live, _html} = live(conn, ~p"/admin/companies")

      assert index_live |> element("#companies-#{company.id} a", "Edit") |> render_click() =~
               "Edit Company"

      assert_patch(index_live, ~p"/admin/companies/#{company}/edit")

      assert index_live
             |> form("#company-form", company: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#company-form", company: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/admin/companies")

      html = render(index_live)
      assert html =~ "Company updated successfully"
      assert html =~ @update_attrs.name
    end

    test "deletes company in listing", %{conn: conn, company: company} do
      {:ok, index_live, _html} = live(conn, ~p"/admin/companies")

      assert index_live |> element("#companies-#{company.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#companies-#{company.id}")
    end
  end

  describe "Show" do
    setup [:create_company]

    test "displays company", %{conn: conn, company: company} do
      {:ok, _show_live, html} = live(conn, ~p"/admin/companies/#{company}")

      assert html =~ "Show Company"
      assert html =~ company.name
    end

    test "updates company within modal", %{conn: conn, company: company} do
      {:ok, show_live, _html} = live(conn, ~p"/admin/companies/#{company}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Company"

      assert_patch(show_live, ~p"/admin/companies/#{company}/show/edit")

      assert show_live
             |> form("#company-form", company: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#company-form", company: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/admin/companies/#{company}")

      html = render(show_live)
      assert html =~ "Company updated successfully"
      assert html =~ @update_attrs.name
    end
  end
end
