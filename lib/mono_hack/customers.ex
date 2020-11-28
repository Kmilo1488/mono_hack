defmodule MonoHack.Customers do
  import Ecto.Query, warn: false
  alias MonoHack.Repo

  alias MonoHack.Customers.Customer

  def list_customers do
    Repo.all(Customer)
  end

  def get_customer!(id), do: Repo.get!(Customer, id)

  def create_customer(attrs \\ %{}) do
    %Customer{}
    |> Customer.changeset(attrs)
    |> Repo.insert()
  end

  def change_customer(%Customer{} = customer, attrs \\ %{}) do
    Customer.changeset(customer, attrs)
  end
end
