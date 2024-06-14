defmodule Foodtrunk.Schema.Types.Root do
  use Absinthe.Schema.Notation

  alias Foodtrunk.Resolvers.FoodTruck, as: FoodTruckResolver

  import_types Foodtrunk.Schema.Types.FoodTruck

  object :root_query do
    field :get_food_truck, type: :food_truck do
      arg :id, non_null(:id)

      resolve &FoodTruckResolver.get/2
    end
    field :list_all_food_trucks, type: list_of(:food_truck) do
      resolve &FoodTruckResolver.list/2
    end
  end
  object :root_mutation do
    field :create_food_truck, type: :food_truck do
      arg :input, non_null(:create_food_truck_input)

      resolve &FoodTruckResolver.create/2
    end

    field :update_food_truck, type: :food_truck do
      arg :input, non_null(:update_food_truck_input)

      resolve &FoodTruckResolver.update/2
    end

    field :delete_food_truck, type: :delete_food_truck_result do
      arg :id, non_null(:id)

      resolve &FoodTruckResolver.delete/2
    end
  end
end
