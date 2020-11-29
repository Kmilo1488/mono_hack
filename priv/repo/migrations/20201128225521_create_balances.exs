defmodule MonoHack.Repo.Migrations.CreateBalances do
  use Ecto.Migration

  def change do
    create table(:balances) do
      add :amount, :integer
      add :customer_id, references(:customers, on_delete: :nothing)

      timestamps()
    end

    create unique_index(:balances, [:customer_id])
  end
end
