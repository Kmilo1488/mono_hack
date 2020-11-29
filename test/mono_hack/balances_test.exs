defmodule MonoHack.BalancesTest do
  use MonoHack.DataCase

  alias MonoHack.Balances
  alias MonoHack.Customers

  describe "balances" do
    alias MonoHack.Balances.Balance

    @invalid_attrs %{amount: nil}
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

    test "get_balance!/1 returns the balance with given id" do
      balance = balance_fixture()
      assert Balances.get_balance!(balance.id) == balance
    end

    test "create_balance/1 with valid data creates a balance" do
      assert {:ok, %Balance{} = balance} = Balances.create_balance(valid_params())
      assert balance.amount == 42
    end

    test "create_balance/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Balances.create_balance(@invalid_attrs)
    end

    test "change_balance/1 returns a balance changeset" do
      balance = balance_fixture()
      assert %Ecto.Changeset{} = Balances.change_balance(balance)
    end
  end
end
