defmodule Foodtrunk.Repo.Migrations.CreateFoodtrucks do
  use Ecto.Migration

  def change do
    create table(:foodtrucks) do
      add :name, :string
      add :type, :string
      add :location, :string
      add :address, :string
      add :food_items, :text
      add :latitude, :float
      add :longitude, :float
      add :schedule_url, :string
      add :schedule, :string
      add :deleted_at, :utc_datetime

      timestamps(type: :utc_datetime)
    end
  end
end
