defmodule MonoHackWeb.TransactionControllerTest do
  use MonoHackWeb.ConnCase
  
  alias MonoHack.Balances
  alias MonoHack.Customers

  @valid_attrs %{amount: "20", transfer_type: "credit"}
  @invalid_attrs %{amount: nil, transfer_type: nil, balance_id: nil}
  @customer_attrs %{email: "some email", name: "some name"}

  def customer_fixture(attrs \\ %{}) do
    {:ok, customer} =
      attrs
      |> Enum.into(@customer_attrs)
      |> Customers.create_customer()

    customer
  end

  def valid_params do
    customer = customer_fixture()
    %{amount: 42, customer_id: customer.id}
  end

  def balance_fixture(attrs \\ %{}) do
    {:ok, balance} =
      attrs
      |> Enum.into(valid_params())
      |> Balances.create_balance()

    balance
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "renders transaction when data is valid", %{conn: conn} do
    balance = balance_fixture()
    params = Map.put(@valid_attrs, :balance_id, balance.id)

    conn = post(conn, Routes.transaction_path(conn, :create, params))
    assert json_response(conn, 201)
  end

  test "renders errors when data is invalid", %{conn: conn} do
    conn = post(conn, Routes.transaction_path(conn, :create,  @invalid_attrs))
    assert json_response(conn, 422) != %{}
  end
end
