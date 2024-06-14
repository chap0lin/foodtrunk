defmodule Foodtrunk.Repo do
  use Ecto.Repo,
    otp_app: :foodtrunk,
    adapter: Ecto.Adapters.Postgres
end
