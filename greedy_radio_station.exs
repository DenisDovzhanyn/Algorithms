defmodule GreedyRadioStation do

  def greedy_radio_station(states_needed, stations, final_stations) do
    if MapSet.size(states_needed) == 0 do
      IO.inspect(final_stations)

    else
      states_covered = MapSet.new()
      {best_station, states_covered} = Enum.reduce(stations, {nil, MapSet.new()}, fn {k, v}, {best_station, states_covered} ->
        covered = MapSet.intersection(states_needed, v)
        if MapSet.size(covered) > MapSet.size(states_covered) do
          {k, covered}
        else
          {best_station, states_covered}
        end
      end)

      final_stations = MapSet.put(final_stations, best_station)
      states_needed = MapSet.difference(states_needed, states_covered)
      greedy_radio_station(states_needed, stations, final_stations)
    end
  end
end

radio_stations = %{
  "Station A" => MapSet.new(["CA", "NV", "UT"]),
  "Station B" => MapSet.new(["WA", "OR", "ID"]),
  "Station C" => MapSet.new(["CA", "AZ", "NV"]),
  "Station D" => MapSet.new(["TX", "OK", "NM"]),
  "Station E" => MapSet.new(["FL", "GA", "AL"]),
  "Station F" => MapSet.new(["NY", "NJ", "PA"]),
  "Station G" => MapSet.new(["IL", "IN", "WI"]),
  "Station H" => MapSet.new(["UT", "NV", "CO"]),
  "Station I" => MapSet.new(["AZ", "NM", "CO"])
}

states_needed = MapSet.new(["CA", "NV", "UT", "AZ", "NM", "CO", "TX", "OK", "FL", "GA", "AL"])

GreedyRadioStation.greedy_radio_station(states_needed, radio_stations, MapSet.new())
