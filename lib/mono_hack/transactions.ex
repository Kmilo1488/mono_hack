defmodule MonoHack.Transactions do
  import Ecto.Query, warn: false
  require IEx

  alias MonoHack.Repo

  alias MonoHack.Transactions.Transaction

  @topic inspect(__MODULE__)

  def subscribe do
    Phoenix.PubSub.subscribe(MonoHack.PubSub, @topic)
  end

  def list_transactions do
    Repo.all(Transaction)
  end

  def create_transaction(attrs \\ %{}) do
    %Transaction{}
    |> Transaction.changeset(attrs)
    |> Repo.insert()
    |> broadcast_change([:transaction, :created])
  end

  def change_transaction(%Transaction{} = transaction, attrs \\ %{}) do
    Transaction.changeset(transaction, attrs)
  end

  defp broadcast_change({:ok, result}, event) do
    if Phoenix.PubSub.broadcast(MonoHack.PubSub, @topic, {__MODULE__, event, result}) do
      {:ok, result}
    else
      {:error}
    end
  end
end
