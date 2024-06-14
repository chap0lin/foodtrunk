defmodule Foodtrunk.Foodtrucks.Test do
  # use ExUnit.CaseTemplate
  use ExUnit.Case, async: true

  @create_food_truck """
    mutation CreateFoodTruck($input: CreateFoodTruckInput!) {
      createFoodTruck(input: $input) {
        id
        name
        # Include other fields you want to return
      }
    }
  """

  @get_food_truck """
    query GetFoodTruck($id: ID!) {
      getFoodTruck(id: $id) {
        id
        name
      }
    }
  """

  @delete_food_truck """
    mutation DeleteFoodTruck($id: ID!) {
      deleteFoodTruck(id: $id) {
        success
      }
    }
  """

  setup do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Foodtrunk.Repo)
  end

  describe "foodtrucks crud" do
    test "should fail to create new foodtruck if missing required params" do
      input_variables = %{
        "input" => %{
          "name" => "Test Food Truck",
          "latitude" => 123.456,
          "longitude" => -123.456
        }
      }

      {:ok, result} =
        Absinthe.run(@create_food_truck, FoodtrunkWeb.Schema, variables: input_variables)

      assert %{errors: _} = result
    end

    test "should create new foodtruck with valid input" do
      input_variables = %{
        "input" => %{
          "name" => "Test Food Truck",
          "latitude" => 123.456,
          "longitude" => -123.456,
          "address" => "123 number street",
          "scheduleUrl" => "url"
        }
      }

      {:ok, result} =
        Absinthe.run(@create_food_truck, FoodtrunkWeb.Schema, variables: input_variables)

      assert %{data: %{"createFoodTruck" => _}} = result
    end

    test "list call should retrieve all foodtruck data" do
      input_variables = %{
        "input" => %{
          "name" => "Test Food Truck",
          "latitude" => 123.456,
          "longitude" => -123.456,
          "address" => "123 number street",
          "scheduleUrl" => "url"
        }
      }

      {:ok, _} = Absinthe.run(@create_food_truck, FoodtrunkWeb.Schema, variables: input_variables)
      {:ok, _} = Absinthe.run(@create_food_truck, FoodtrunkWeb.Schema, variables: input_variables)

      query = """
        query {
          listAllFoodTrucks {
            id
            name
          }
        }
      """

      assert {:ok, %{data: %{"listAllFoodTrucks" => results}}} =
               Absinthe.run(query, FoodtrunkWeb.Schema, variables: %{})

      assert length(results) === 2
    end

    test "get call should retrieve foodtruck data" do
      input_variables = %{
        "input" => %{
          "name" => "Super Hot Dog",
          "latitude" => 123.456,
          "longitude" => -123.456,
          "address" => "123 number street",
          "scheduleUrl" => "url"
        }
      }

      {:ok, %{data: %{"createFoodTruck" => foodtruck}}} =
        Absinthe.run(@create_food_truck, FoodtrunkWeb.Schema, variables: input_variables)

      id = foodtruck["id"]

      assert {:ok, %{data: %{"getFoodTruck" => result}}} =
               Absinthe.run(@get_food_truck, FoodtrunkWeb.Schema, variables: %{"id" => id})

      assert result["id"] == id
      assert result["name"] == "Super Hot Dog"
    end

    test "get should fail if foodtruck not found" do
      id = 99999

      assert {:ok, %{data: %{"getFoodTruck" => result}, errors: [error | _]}} =
               Absinthe.run(@get_food_truck, FoodtrunkWeb.Schema, variables: %{"id" => id})

      assert result == nil
      assert error.message == "FoodTruck not found"
    end

    test "delete should fail if foodtruck not found" do
      id = 99999

      assert {:ok, %{data: %{"deleteFoodTruck" => result}, errors: [error | _]}} =
               Absinthe.run(@delete_food_truck, FoodtrunkWeb.Schema, variables: %{"id" => id})

      assert result == nil
      assert error.message == "FoodTruck not found"
    end

    test "delete should succeed if foodtruck found" do
      input_variables = %{
        "input" => %{
          "name" => "Super Hot Dog",
          "latitude" => 123.456,
          "longitude" => -123.456,
          "address" => "123 number street",
          "scheduleUrl" => "url"
        }
      }

      {:ok, %{data: %{"createFoodTruck" => foodtruck}}} =
        Absinthe.run(@create_food_truck, FoodtrunkWeb.Schema, variables: input_variables)

      id = foodtruck["id"]

      assert {:ok, %{data: %{"deleteFoodTruck" => result}}} =
               Absinthe.run(@delete_food_truck, FoodtrunkWeb.Schema, variables: %{"id" => id})

      assert result["success"] == true
    end

    test "update mutation should update foodtruck data" do
      input_variables = %{
        "input" => %{
          "name" => "Super Hot Dog",
          "latitude" => 123.456,
          "longitude" => -123.456,
          "address" => "123 number street",
          "scheduleUrl" => "url"
        }
      }

      {:ok, %{data: %{"createFoodTruck" => foodtruck}}} =
        Absinthe.run(@create_food_truck, FoodtrunkWeb.Schema, variables: input_variables)

      id = foodtruck["id"]

      query = """
        mutation UpdateFoodTruck($input: UpdateFoodTruckInput!) {
          updateFoodTruck(input: $input) {
            name
          }
        }
      """

      update_variables = %{
        "input" => %{
          "id" => id,
          "name" => "Ultra Hot Dog"
        }
      }

      assert {:ok, %{data: %{"updateFoodTruck" => result}}} =
               Absinthe.run(query, FoodtrunkWeb.Schema, variables: update_variables)

      assert result["name"] == "Ultra Hot Dog"
    end
  end
end
