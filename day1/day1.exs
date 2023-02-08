defmodule Day1 do
  def sum_lists([head | tail], accumulator, sums) do
    if head == "" do
      sum_lists(tail, 0, [accumulator | sums])
    else
      {head_value, ""} = Integer.parse(head)
      sum_lists(tail, head_value + accumulator, sums)
    end
  end

  def sum_lists([], _accumulator, sums) do
    sums
  end
  # can do the same thing above....
  def sum_list_with_max([head | tail], accumulator, max) do
   	# pull 18-22 into function and handle negative first.
    if head == "" do
  		if accumulator > max do
  			sum_list_with_max(tail, 0 , accumulator)
  		else
  			sum_list_with_max(tail, 0, max)
  		end
  	else
  	  {head_value, ""} = Integer.parse(head)
	  sum_list_with_max(tail, head_value + accumulator, max)
  	end
  end

  def sum_list_with_max([], _accumulator, max) do
    max
  end
end

{:ok, contents} = File.read("day1.txt")
caloriesString = contents |> String.split("\n", trim: false)
max = Day1.sum_list_with_max(caloriesString, 0, 0)

IO.puts("Part 2:")
IO.puts(Day1.sum_lists(caloriesString, 0, []) |> Enum.sort |> Enum.take(-3) |> Enum.sum())

IO.puts("Part 1: ")
IO.puts(max)

IO.puts("Part 1 another way")
value = Day1.sum_lists(caloriesString, 0, []) |> Enum.sort |> Enum.take(-1) |> Enum.sum()
IO.puts(value)
