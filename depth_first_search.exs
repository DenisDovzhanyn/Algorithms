defmodule DepthFirstSearch do
  def depth_first_search(maze, start_point, end_point, visited) do
    IO.puts(start_point)
    :timer.sleep(1000)

    if start_point == end_point do
      IO.puts('found exit!')
      IO.puts(start_point)
      {:ok, start_point}
    else
      visited = MapSet.put(visited, start_point)
      Enum.reduce_while(Map.get(maze,start_point), :not_found, fn x, acc ->
        if MapSet.member?(visited, x) do
          {:cont, acc}
        else
          case depth_first_search(maze, x, end_point, visited) do
            {:ok, res} = result -> {:halt, result}

            :not_found -> {:cont, acc}
          end
        end
      end)
    end
  end
end

DepthFirstSearch.depth_first_search(%{
  "1-1" => ["1-2", "2-1"], # Start
  "1-2" => ["1-1", "1-3"],
  "1-3" => ["1-2", "2-3"],
  "2-1" => ["1-1", "3-1"],
  "2-3" => ["1-3", "3-3"],
  "3-1" => ["2-1", "3-3"],
  "3-3" => ["2-3", "3-1", "3-4"],
  "3-4" => ["3-3", "3-5"],
  "3-5" => ["3-4", "4-5"],
  "4-5" => ["3-5", "5-5"],
  "5-5" => ["4-5", "5-4"], # Exit
  "5-4" => ["5-5", "5-3"],
  "5-3" => ["5-4", "5-2"],
  "5-2" => ["5-3", "5-1"],
  "5-1" => ["5-2"]
}, "1-1", "5-5", MapSet.new())
