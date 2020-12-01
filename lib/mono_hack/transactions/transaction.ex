defmodule MonoHack.Transactions.Transaction do
  use Ecto.Schema
  import Ecto.Changeset

  schema "transactions" do
    field :amount, :integer
    field :transfer_type, :string
    field :balance_id, :id

    timestamps()
  end

  @doc false
  def changeset(transaction, attrs) do
    transaction
    |> cast(attrs, [:amount, :transfer_type, :balance_id])
    |> validate_required([:amount, :transfer_type, :balance_id])
  end
end
