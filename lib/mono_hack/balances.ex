defmodule MonoHack.Balances do
  import Ecto.Query, warn: false
  alias MonoHack.Repo
  require IEx

  alias MonoHack.Balances.Balance
  alias MonoHack.Transactions

  def get_balance!(id) do
    Balance
    |> Repo.get!(id)
    |> Repo.preload(:transactions)
  end

  def create_balance(attrs \\ %{}) do
    %Balance{}
    |> Balance.changeset(attrs)
    |> Repo.insert()
  end

  def transfer_call(attrs) do
    amount = String.to_integer(attrs["amount"])
    cond do
      attrs["transfer_type"] == "debit" ->
        debit(attrs["balance_id"], amount)
      attrs["transfer_type"] == "credit" ->
        credit(attrs["balance_id"], amount)
      true ->
        false
    end
  end

  defp debit(id, amount) do
    balance = Repo.get!(Balance, id)
    if balance.amount >= amount do
      new_amount = balance.amount - amount
      Ecto.Changeset.change(balance, %{amount: new_amount}) |> Repo.update!
      {:ok, balance}
    else
      false
    end
  end

  defp credit(id, amount) do
    balance = Repo.get!(Balance, id)
    new_amount = balance.amount + amount
    Ecto.Changeset.change(balance, %{amount: new_amount}) |> Repo.update!
    {:ok, balance}
  end

  def change_balance(%Balance{} = balance, attrs \\ %{}) do
    Balance.changeset(balance, attrs)
  end
end
