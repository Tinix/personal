defmodule Personal.Repo do
  use Ecto.Repo,
    otp_app: :personal,
    adapter: Ecto.Adapters.Postgres
end
