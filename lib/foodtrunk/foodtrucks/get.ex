defmodule Foodtrunk.FoodTrucks.Get do
  import Ecto.Query
  alias Foodtrunk.{FoodTruck, Repo}

  def call(id) do
    FoodTruck
    |> where([ft], is_nil(ft.deleted_at))
    |> Repo.get(id)
    |> case do
      nil -> {:error, "FoodTruck not found"}
      foodtruck -> {:ok, foodtruck}
    end
  end
end
