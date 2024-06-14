defmodule Foodtrunk.FoodTruck do
  use Ecto.Schema
  import Ecto.Changeset

  @required [:name, :address, :latitude, :longitude, :schedule_url]
  @optional [:type, :location, :food_items, :schedule, :deleted_at]

  schema "foodtrucks" do
    field :name, :string
    field :type, :string, default: nil
    field :address, :string
    field :location, :string, default: nil
    field :food_items, :string, default: nil
    field :latitude, :float
    field :longitude, :float
    field :schedule_url, :string
    field :schedule, :string, default: nil
    field :deleted_at, :utc_datetime, default: nil

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(food_truck, attrs) do
    food_truck
    |> cast(attrs, @required ++ @optional)
    |> validate_required(@required)
  end

  def changeset(attrs) do
    %__MODULE__{}
    |> cast(attrs, @required ++ @optional)
    |> validate_required(@required)
  end
end
