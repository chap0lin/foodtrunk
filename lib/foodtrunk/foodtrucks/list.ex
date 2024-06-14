defmodule Foodtrunk.FoodTrucks.List do
  import Ecto.Query
  alias Foodtrunk.{FoodTruck, Repo}

  def call() do
    result = FoodTruck
    |> where(is_nil(:deleted_at))
    |> Repo.all()
    {:ok, result}
  end
end
