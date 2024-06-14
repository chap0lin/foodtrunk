defmodule Foodtrunk.Schema.Types.FoodTruck do
  use Absinthe.Schema.Notation

  object :food_truck do
    field :id, non_null(:id)
    field :name, non_null(:string)
    field :type, :string
    field :address, non_null(:string)
    field :location, :string
    field :food_items, :string
    field :latitude, non_null(:float)
    field :longitude, non_null(:float)
    field :schedule_url, non_null(:string)
    field :schedule, :string
  end

  input_object :create_food_truck_input do
    field :name, non_null(:string)
    field :type, :string
    field :address, non_null(:string)
    field :location, :string
    field :food_items, :string
    field :latitude, non_null(:float)
    field :longitude, non_null(:float)
    field :schedule_url, non_null(:string)
    field :schedule, :string
  end

  input_object :update_food_truck_input do
    field :id, non_null(:id)
    field :name, :string
    field :type, :string
    field :address, :string
    field :location, :string
    field :food_items, :string
    field :latitude, :float
    field :longitude, :float
    field :schedule_url, :string
    field :schedule, :string
  end

  object :delete_food_truck_result do
    field :success, non_null(:boolean)
  end
end
