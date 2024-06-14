defmodule Foodtrunk.FoodTrucks.List do
  import Ecto.Query
  alias Foodtrunk.{FoodTruck, Repo}

  def call() do
    result =
      FoodTruck
      |> where([ft], is_nil(ft.deleted_at))
      |> Repo.all()

    {:ok, result}
  end
end
