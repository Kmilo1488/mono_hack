defmodule MonoHack.Repo.Migrations.CreateTransactions do
  use Ecto.Migration

  def change do
    create table(:transactions) do
      add :amount, :integer
      add :transfer_type, :string
      add :balance_id, references(:balances, on_delete: :delete_all)

      timestamps()
    end

    create index(:transactions, [:balance_id])
  end
end
