defmodule BinarySearch do

  def begin_binary_search(tuple, target) do
    range = 0..tuple_size(tuple) - 1

    binary_search(tuple, target, range)
  end

  def binary_search(tuple, target, range) do

    if range.first > range.last do
      IO.puts('target not found')
    else
      middle_index = div(range.last + range.first, 2)
      middle = elem(tuple, middle_index)


      cond do
        middle == target ->
          IO.puts(middle)
          middle

        middle > target -> binary_search(tuple, target, range.first..middle_index - 1)

        middle < target -> binary_search(tuple, target, middle_index + 1..range.last)
      end
    end
  end

  def run() do
    tuple = {10,20,30,40,50,60,70,80,90,100}
    target = 20
    begin_binary_search(tuple, target)
  end
end

BinarySearch.run()
