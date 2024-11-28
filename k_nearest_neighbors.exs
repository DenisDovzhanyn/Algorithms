defmodule KNearestNeighbors do

  def k_nearest_neighbors(k, graph, new_point) do
    distances = Enum.sort(find_distances(graph, new_point), fn {_, distance1}, {_, distance2} -> distance1 < distance2 end)
    IO.inspect(distances)
    count = Enum.reduce_while(distances, {%{}, 0}, fn {class, _distance}, {classes, count} ->
      if count > k do
        {:halt, classes}
      else
        updated_map = Map.update(classes, class, 1, &(&1 + 1))
        {:cont, {updated_map, count + 1}}
      end
    end)

    {determined_class, _count} = Enum.reduce(count, {:nil, 0} , fn {k,v}, {class, count} ->
      if v >= count do
        {k, v}
      else
        {class, count}
      end
    end)

    IO.puts("the new plot is a #{determined_class}")
  end

  defp find_distances(graph, new_point) do
    Enum.reduce(graph, [], fn map, list ->
      classification = map["class"]
      distance = :math.sqrt((new_point["x"] - map["x"]) ** 2 + (new_point["y"] - map["y"]) ** 2 )
      [{classification, distance} | list]
      end)
  end
end

data = [
  %{"class" => "dog", "x" => 8, "y" => 5},
  %{"class" => "dog", "x" => 9, "y" => 7},
  %{"class" => "dog", "x" => 7, "y" => 6},
  %{"class" => "cat", "x" => 3, "y" => 2},
  %{"class" => "cat", "x" => 4, "y" => 3},
  %{"class" => "cat", "x" => 5, "y" => 2},
  %{"class" => "bunny", "x" => 2, "y" => 8},
  %{"class" => "bunny", "x" => 4, "y" => 9},
  %{"class" => "bunny", "x" => 3, "y" => 7}
]

new_plot = %{"x" => 6, "y" => 4}

KNearestNeighbors.k_nearest_neighbors(3, data, new_plot)
