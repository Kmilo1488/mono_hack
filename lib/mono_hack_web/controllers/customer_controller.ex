defmodule MonoHackWeb.CustomerController do
  use MonoHackWeb, :controller

  alias MonoHack.Customers
  alias MonoHack.Customers.Customer
  alias MonoHack.Balances.Balance

  def index(conn, _params) do
    customers = Customers.list_customers()
    render(conn, "index.html", customers: customers)
  end

  def new(conn, _params) do
    changeset = Customers.change_customer(%Customer{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"customer" => customer_params}) do
    case Customers.create_customer(customer_params) do
      {:ok, customer} ->
        conn
        |> put_flash(:info, "Customer created successfully.")
        |> redirect(to: Routes.customer_path(conn, :show, customer))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def add_balance(conn, %{"balance" => balance_params, "customer_id" => customer_id}) do
    customer = Customers.get_customer!(customer_id)
    case Customers.add_balance(customer_id, balance_params) do
      {:ok, _balance} ->
        conn
        |> put_flash(:info, "Balance created successfully")
        |> redirect(to: Routes.customer_path(conn, :show, customer))
      {:error, _error} ->
        conn
        |> put_flash(:error, "Oops! Couldn't create balance!")
        |> redirect(to: Routes.customer_path(conn, :show, customer))
    end
  end

  def show(conn, %{"id" => id}) do
    customer = Customers.get_customer!(id)
    changeset = Balance.changeset(%Balance{}, %{})
    render(conn, "show.html", customer: customer, changeset: changeset)
  end
end
