defmodule MonoHack.Customers.Customer do
  use Ecto.Schema
  import Ecto.Changeset

  alias MonoHack.Balances.Balance

  schema "customers" do
    field :email, :string
    field :name, :string
    has_one :balance, Balance

    timestamps()
  end

  @doc false
  def changeset(customer, attrs) do
    customer
    |> cast(attrs, [:name, :email])
    |> validate_required([:name, :email])
  end
end
