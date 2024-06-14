defmodule InitialSeed do
  defp parse(file_path) do
    File.stream!(file_path)
    # skipping first row
    |> Stream.drop(1)
    |> Stream.map(&String.split(&1, ","))
  end

  # locationid,Applicant,FacilityType,cnn,LocationDescription,Address,blocklot,block,lot,permit,Status,FoodItems,X,Y,Latitude,Longitude,Schedule,dayshours,NOISent,Approved,Received,PriorPermit,ExpirationDate,Location,Fire Prevention Districts,Police Districts,Supervisor Districts,Zip Codes,Neighborhoods (old)
  defp insert_food_truck(values) do
    [
      _,
      applicant,
      facilityType,
      _,
      locationDescription,
      address,
      _,
      _,
      _,
      _,
      _,
      foodItems,
      _,
      _,
      latitude,
      longitude,
      schedule,
      dayshours | _
    ] = values

    Foodtrunk.Repo.transaction(fn ->
      Foodtrunk.FoodTrucks.Create.call(%{
        name: applicant,
        type: facilityType,
        location: locationDescription,
        address: address,
        food_items: foodItems,
        latitude: latitude,
        longitude: longitude,
        schedule_url: schedule,
        schedule: dayshours
      })
      |> case do
        {:ok, _} -> IO.puts("Record created for #{applicant}")
        {:error, changeset} -> IO.puts("Error creating record: #{inspect(changeset.errors)}")
      end
    end)
  end

  defp import_from_csv(csv_file) do
    parse(csv_file)
    |> Enum.each(&insert_food_truck/1)
  end

  def run() do
    file_name = Path.join([:code.priv_dir(:foodtrunk), "Mobile_Food_Facility_Permit.csv"])
    import_from_csv(file_name)
  end
end

InitialSeed.run()
