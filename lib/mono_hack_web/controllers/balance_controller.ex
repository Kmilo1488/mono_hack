defmodule MonoHackWeb.BalanceController do
  use MonoHackWeb, :controller

  alias MonoHack.Customers
  alias MonoHack.Balances

  def show(conn, %{"customer_id" => customer_id, "id" => id}) do
    customer = Customers.get_customer!(customer_id)
    balance = Balances.get_balance!(id)
    render(conn, "show.html", customer: customer, balance: balance)
  end

end
