# MonoHack

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Install Node.js dependencies with `npm install` inside the `assets` directory
  * Start Phoenix endpoint with `mix phx.server`
  * Runs Test `mix test`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

  * TransactionLiveView go to `http://localhost:4000/transactions`
  * API transaction POST `http://localhost:4000/api/transaction`
    * transfer_types `["debit", "credit"]`
    * Body example `{"amount": 100, "transfer_type": "credit", "balance_id": 1 }`
