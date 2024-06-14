defmodule Foodtrunk.FoodTrucks.Create do
  alias Foodtrunk.{FoodTruck, Repo}

  def call(params) do
    params
    |> FoodTruck.changeset()
    |> Repo.insert()
  end
end
