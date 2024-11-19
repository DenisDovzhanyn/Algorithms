defmodule QuickSort do

  def quick_sort(list) do
    size = Kernel.length(list)

    if size <= 1 do
      list
    else
      IO.inspect(list)
      pivot = div(size, 2)
      pivot_num = Enum.at(list, pivot)
      left = Enum.filter(list, &(&1 < pivot_num))
      right = Enum.filter(list, &(&1 > pivot_num))
      middle = Enum.filter(list, &(&1 == pivot_num))

      quick_sort(left) ++ middle ++ quick_sort(right)
    end
  end
end

IO.inspect(QuickSort.quick_sort([3,1,5,7,8,3,3,1,100,23,43,565,234,123,44,22,66,11,34,62,12,42]))
# prints [1, 1, 3, 3, 3, 5, 7, 8, 11, 12, 22, 23, 34, 42, 43, 44, 62, 66, 100, 123, 234, 565]
