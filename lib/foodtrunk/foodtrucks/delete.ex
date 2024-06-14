defmodule Foodtrunk.FoodTrucks.Delete do
  import Ecto.Query
  alias Foodtrunk.{FoodTruck, Repo}

  def call(id) do
    FoodTruck
    |> where([ft], is_nil(ft.deleted_at))
    |> Repo.get(id)
    |> case do
      nil -> {:error, "FoodTruck not found"}
      foodtruck ->
        params = Map.put(%{}, :deleted_at, DateTime.utc_now())
        changeset = FoodTruck.changeset(foodtruck, params)
        Repo.update(changeset)
        {:ok, %{success: true}}
    end
  end
end
