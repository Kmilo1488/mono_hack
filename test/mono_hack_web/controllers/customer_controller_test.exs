defmodule MonoHackWeb.CustomerControllerTest do
  use MonoHackWeb.ConnCase

  alias MonoHack.Customers

  @create_attrs %{email: "some email", name: "some name"}
  @invalid_attrs %{email: nil, name: nil}
  @balance_attrs %{amount: 300}
  @invalid_balance_attrs %{amount: nil}

  def fixture(:customer) do
    {:ok, customer} = Customers.create_customer(@create_attrs)
    customer
  end

  def customer_fixture(attrs \\ %{}) do
    {:ok, customer} =
      attrs
      |> Enum.into(@create_attrs)
      |> Customers.create_customer()

    customer
  end

  describe "index" do
    test "lists all customers", %{conn: conn} do
      conn = get(conn, Routes.customer_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Customers"
    end
  end

  describe "new customer" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.customer_path(conn, :new))
      assert html_response(conn, 200) =~ "New Customer"
    end
  end

  describe "create customer" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.customer_path(conn, :create), customer: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.customer_path(conn, :show, id)

      conn = get(conn, Routes.customer_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Customer"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.customer_path(conn, :create), customer: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Customer"
    end
  end

  describe "add balance" do
    test "redirects to show when balance is valid", %{conn: conn} do
      customer = customer_fixture()

      conn = post(conn, Routes.customer_customer_path(conn, :add_balance, customer), balance: @balance_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.customer_path(conn, :show, id)

      conn = get(conn, Routes.customer_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Customer"
    end

    test "renders errors when balance is invalid", %{conn: conn} do
      customer = customer_fixture()

      conn = post(conn, Routes.customer_customer_path(conn, :add_balance, customer), balance: @invalid_balance_attrs)
      assert html_response(conn, 302) =~ "<html><body>You are being <a href=\"/#{customer.id}\">redirected</a>.</body></html>"
    end
  end
end
