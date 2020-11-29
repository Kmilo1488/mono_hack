defmodule MonoHack.Balances do
  @moduledoc """
  The Balances context.
  """

  import Ecto.Query, warn: false
  alias MonoHack.Repo

  alias MonoHack.Balances.Balance

  def get_balance!(id), do: Repo.get!(Balance, id)

  def create_balance(attrs \\ %{}) do
    %Balance{}
    |> Balance.changeset(attrs)
    |> Repo.insert()
  end

  def change_balance(%Balance{} = balance, attrs \\ %{}) do
    Balance.changeset(balance, attrs)
  end
end
