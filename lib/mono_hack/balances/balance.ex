defmodule MonoHack.Balances.Balance do
  use Ecto.Schema
  import Ecto.Changeset

  schema "balances" do
    field :amount, :integer
    field :customer_id, :id

    timestamps()
  end

  @doc false
  def changeset(balance, attrs) do
    balance
    |> cast(attrs, [:amount, :customer_id])
    |> validate_required([:amount, :customer_id])
  end
end
