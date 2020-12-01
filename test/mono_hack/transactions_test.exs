defmodule MonoHack.TransactionsTest do
  use MonoHack.DataCase

  alias MonoHack.Transactions
  alias MonoHack.Balances.Balance
  alias MonoHack.Customers.Customer

  describe "transactions" do
    alias MonoHack.Transactions.Transaction

    def customer_fixture() do
      Repo.insert! %Customer{
        email: "some email",
        name: "some name"
      }
    end

    def balance_fixture() do
      customer = customer_fixture()
      Repo.insert! %Balance{
        amount: 40,
        customer_id: customer.id
      }
    end

    def transaction_fixture() do
      balance = balance_fixture()
      Repo.insert! %Transaction{
        amount: 20,
        transfer_type: "debit",
        balance_id: balance.id
      }
    end

    test "list_transactions/0 returns all transactions" do
      transaction = transaction_fixture()
      assert Transactions.list_transactions() == [transaction]
    end

    test "create_transaction/1 with valid data creates a transaction" do
      balance = balance_fixture()
      params = %{amount: "20", transfer_type: "credit", balance_id: balance.id}

      assert {:ok, %Transaction{} = transaction} = Transactions.create_transaction(params)
      assert transaction.amount == 20
      assert transaction.transfer_type == "credit"
    end

    test "change_transaction/1 returns a transaction changeset" do
      transaction = transaction_fixture()
      assert %Ecto.Changeset{} = Transactions.change_transaction(transaction)
    end
  end
end
