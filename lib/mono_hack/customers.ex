defmodule MonoHack.Customers do
  import Ecto.Query, warn: false
  alias MonoHack.Repo

  alias MonoHack.Customers.Customer
  alias MonoHack.Balances

  def list_customers do
    Customer
    |> Repo.all()
    |> Repo.preload(:balance)

  end

  def get_customer!(id) do
    Customer
    |> Repo.get!(id)
    |> Repo.preload(:balance)
  end

  def create_customer(attrs \\ %{}) do
    %Customer{}
    |> Customer.changeset(attrs)
    |> Repo.insert()
  end

  def add_balance(customer_id, balance_params) do
    balance_params
    |> Map.put("customer_id", customer_id)
    |> Balances.create_balance()
  end

  def change_customer(%Customer{} = customer, attrs \\ %{}) do
    Customer.changeset(customer, attrs)
  end
end
