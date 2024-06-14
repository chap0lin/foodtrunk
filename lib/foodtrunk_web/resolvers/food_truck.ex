defmodule Foodtrunk.Resolvers.FoodTruck do
  alias Foodtrunk.FoodTrucks
  def get(%{id: food_truck_id}, _context), do: FoodTrucks.Get.call(food_truck_id)
  def create(%{input: params}, _context), do: FoodTrucks.Create.call(params)
  def list(_, _context), do: FoodTrucks.List.call()
  def update(%{input: params}, _context), do: FoodTrucks.Update.call(params)
  def delete(%{id: food_truck_id}, _context), do: FoodTrucks.Delete.call(food_truck_id)
end
