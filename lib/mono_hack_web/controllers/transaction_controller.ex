defmodule MonoHackWeb.TransactionController do
  use MonoHackWeb, :controller
  require IEx

  alias MonoHack.Transactions.Transaction
  alias MonoHack.Transactions
  alias MonoHack.Balances

  def create(conn, transaction_params) do
    if Balances.transfer_call(transaction_params) do
      with {:ok, %Transaction{} = transaction} <- Transactions.create_transaction(transaction_params) do
        conn
        |> put_status(:created)
        |> put_resp_header("location", Routes.transaction_path(conn, :show, transaction))
        |> render("show.json", transaction: transaction)
      end
    else
      conn
      |> put_status(:unprocessable_entity)
      |> put_view(MonoHackWeb.ErrorView)
      |> render(:"422")
    end
  end

  def show(conn, %{"id" => id}) do
    transaction = Transaction.get_transaction!(id)
    render(conn, "show.json", transaction: transaction)
  end
end
