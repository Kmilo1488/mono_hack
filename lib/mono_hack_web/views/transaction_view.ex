defmodule MonoHackWeb.TransactionView do
  use MonoHackWeb, :view

  def render("show.json", %{transaction: transaction}) do
    %{
      amount: transaction.amount,
      transfer_type: transaction.transfer_type,
      balance_id: transaction.balance_id
    }
  end
end
