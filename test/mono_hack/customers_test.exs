defmodule MonoHack.CustomersTest do
  use MonoHack.DataCase

  alias MonoHack.Customers

  describe "customers" do
    alias MonoHack.Customers.Customer

    @valid_attrs %{email: "some email", name: "some name"}
    @invalid_attrs %{email: nil, name: nil}

    def customer_fixture(attrs \\ %{}) do
      {:ok, customer} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Customers.create_customer()

      customer
    end

    test "list_customers/0 returns all customers" do
      customer = customer_fixture()
      assert Enum.count(Customers.list_customers()) == Enum.count([customer])
    end

    test "get_customer!/1 returns the customer with given id" do
      customer = customer_fixture()
      get_customer = Customers.get_customer!(customer.id)
      assert customer.email == get_customer.email
      assert customer.name == get_customer.name
    end

    test "create_customer/1 with valid data creates a customer" do
      assert {:ok, %Customer{} = customer} = Customers.create_customer(@valid_attrs)
      assert customer.email == "some email"
      assert customer.name == "some name"
    end

    test "create_customer/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Customers.create_customer(@invalid_attrs)
    end
  end
end
