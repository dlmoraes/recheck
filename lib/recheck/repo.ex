defmodule Recheck.Repo do
  use Ecto.Repo,
    otp_app: :recheck,
    adapter: Ecto.Adapters.Postgres
end
