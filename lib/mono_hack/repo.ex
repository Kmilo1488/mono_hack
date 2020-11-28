defmodule MonoHack.Repo do
  use Ecto.Repo,
    otp_app: :mono_hack,
    adapter: Ecto.Adapters.Postgres
end
