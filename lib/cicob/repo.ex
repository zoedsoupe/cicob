defmodule Cicob.Repo do
  use Ecto.Repo,
    otp_app: :cicob,
    adapter: Ecto.Adapters.Postgres
end
