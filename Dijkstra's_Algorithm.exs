defmodule DijkstrasAlgorithm do
  def dijkstra_algorithm(graph, times, parents, processed) do
    node = lowest_time_node(times, processed)

    if node != nil do
      time = times[node]
      neighbors = graph[node]

      {new_times, new_parents} = Enum.reduce(neighbors, {times, parents}, fn {k,v}, {times, parents} ->
          new_time = time + v
          if Map.get(times, k) > new_time do
            new_time = Map.put(times, k, new_time)
            new_parents = Map.put(parents, k, node)
            {new_time, new_parents}
          else
            {times,parents}
          end

        end)
      new_processed = MapSet.put(processed, node)
      dijkstra_algorithm(graph, new_times, new_parents, new_processed)
    else
      {times, parents}
    end
  end

  def lowest_time_node(node_time, processed) do
    {lowest_node, _} = Enum.reduce(node_time, {nil, :infinity}, fn {k, v}, {lowest_time_node, lowest_time} ->
      if v < lowest_time && !MapSet.member?(processed, k) do
        {k, v}
      else
        {lowest_time_node, lowest_time}
      end
    end)
    lowest_node
  end

end





times = %{"start" => 0, "B" => :infinity, "C" => :infinity, "D" => :infinity}
parents = %{}
graph = %{
  "start" => [{"B", 2}, {"C", 5}, {"D", 1}],
  "B" => [{"E", 4}, {"F", 7}],
  "C" => [{"F", 3}, {"G", 6}],
  "D" => [{"G", 2}],
  "E" => [{"finish", 1}],
  "F" => [{"finish", 2}],
  "G" => [{"finish", 4}],
  "finish" => []
}

{times, parents} = DijkstrasAlgorithm.dijkstra_algorithm(graph,times,parents, MapSet.new())
IO.inspect(times)
IO.inspect(parents)
