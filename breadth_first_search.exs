defmodule BreadthFirstSearch do
  def breadth_first_search(queue, map, first_node, target, already_seen) do

    queue = Enum.reduce(Map.get(map, first_node), queue, fn item, acc ->
      :queue.in(item, acc)
    end)

    if :queue.is_empty(queue) do
      nil
    else
      {{:value, person}, new_queue} = :queue.out(queue)

      if person == target do
        person
      else
        already_seen = MapSet.put(already_seen, person)
        breadth_first_search(new_queue, map, person, target, already_seen)
      end
    end
  end


end


BreadthFirstSearch.breadth_first_search(:queue.new(), %{
 'start' => ['bob', 'charlie', 'sav'],
 'bob' => ['judy', 'yellow','purple'],
 'charlie' => ['sav', 'jones', 'alien'],
 'sav' => [],
 'judy' => [],
 'yellow' => [],
 'purple' => ['john'],
 'jones' => [],
 'alien' => [],
 'john' => []},
  'start', 'alien', MapSet.new())
