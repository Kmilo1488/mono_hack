defmodule MonoHackWeb.TransactionLive do
  use MonoHackWeb, :live_view
  use Phoenix.HTML

  alias MonoHack.Transactions
  alias MonoHack.Transactions.Transaction
  alias MonoHack.Customers
  alias MonoHack.Balances

  def mount(_params, _session, socket) do
    Transactions.subscribe()

    {:ok, fetch(socket)}
  end

  def handle_event("validate", %{"transaction" => params}, socket) do
    changeset =
      %Transaction{}
      |> Transactions.change_transaction(params)
      |> Map.put(:action, :insert)

    {:noreply, assign(socket, changeset: changeset)}
  end

  def handle_event("add", %{"transaction" => transaction_params}, socket) do
    if Balances.transfer_call(transaction_params) do
      Transactions.create_transaction(transaction_params)
      {:noreply,
        socket
        |> put_flash(:info, "Transaction created")}
    else
      {:noreply,
        socket
        |> put_flash(:error, "Invalid amount to debit")}
    end
  end

  def handle_info({Transactions, [:transaction | _], _}, socket) do
    {:noreply, fetch(socket)}
  end

  defp fetch(socket) do
    assign(socket, %{
      transactions: Transactions.list_transactions(),
      customers: Customers.list_customers(),
      changeset: Transactions.change_transaction(%Transaction{})
    })
  end
end
