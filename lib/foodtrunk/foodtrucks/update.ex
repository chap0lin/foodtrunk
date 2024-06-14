defmodule Foodtrunk.FoodTrucks.Update do
  import Ecto.Query
  alias Foodtrunk.{FoodTruck, Repo}

  def call(params) do
    FoodTruck
    |> where([ft], is_nil(ft.deleted_at))
    |> Repo.get(params.id)
    |> case do
      nil -> {:error, "FoodTruck not found"}
      foodtruck ->
        changeset = FoodTruck.changeset(foodtruck, params)
        Repo.update(changeset)
    end
  end
end
