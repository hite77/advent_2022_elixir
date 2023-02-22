defmodule Day11 do
  @moduledoc """
  Documentation for `Day11`.
  """

  @doc """
  Parses input into map

  ## Examples

      iex> Day11.parse("Monkey 4:", [3, %{3 => [{}, 0]}])
      [4, %{3 => [{}, 0], 4 => [{}]}]

      iex> Day11.parse("Starting items: 79, 98", [4, %{4 => [{}]}])
      [4, %{4 => [{[79,98]}]}]

      iex> Day11.parse("Operation: new = old * 11", [4, %{4 => [{[79,98]}]}])
      [4, %{4 => [{[79,98],"times", 11}]}]

      iex> Day11.parse("Operation: new = old + 14", [4, %{4 => [{[79,98]}]}])
      [4, %{4 => [{[79,98],"plus", 14}]}]

      iex> Day11.parse("Operation: new = old * old", [4, %{4 => [{[79,98]}]}])
      [4, %{4 => [{[79,98],"times", "self"}]}]

      iex> Day11.parse("Operation: new = old + old", [4, %{4 => [{[79,98]}]}])
      [4, %{4 => [{[79,98],"plus", "self"}]}]

      iex> Day11.parse("Test: divisible by 5", [4, %{4 => [{[79,98],"plus", "self"}]}])
      [4, %{4 => [{[79,98],"plus", "self", 5}]}]

      iex> Day11.parse("If true: throw to monkey 23", [4, %{4 => [{[79,98],"plus", "self", 5}]}])
      [4, %{4 => [{[79,98],"plus", "self", 5, 23}]}]

      iex> Day11.parse("If false: throw to monkey 42", [4, %{4 => [{[79,98],"plus", "self", 5, 23}]}])
      [4, %{4 => [{[79,98],"plus", "self", 5, 23, 42}, 0]}]

  """
  def parse("If false: throw to monkey " <> number, [currentMonkey, map]) do
    [{startingItems, type, count, divisible, trueMonkey}] = map[currentMonkey]
    map = put_in(map[currentMonkey], [{startingItems, type, count, divisible, trueMonkey, String.to_integer(number)} , 0])
    [currentMonkey, map]
  end
  def parse("If true: throw to monkey " <> number, [currentMonkey, map]) do
    [{startingItems, type, count, divisible}] = map[currentMonkey]
    map = put_in(map[currentMonkey], [{startingItems, type, count, divisible, String.to_integer(number)}])
    [currentMonkey, map]
  end
  def parse("Test: divisible by " <> number, [currentMonkey, map]) do
    [{startingItems, type, count}] = map[currentMonkey]
    map = put_in(map[currentMonkey], [{startingItems, type, count, String.to_integer(number)}])
    [currentMonkey, map]
  end
  def parse("Operation: new = old * old", [currentMonkey, map]) do
    [{startingItems}] = map[currentMonkey]
    map = put_in(map[currentMonkey], [{startingItems, "times", "self"}])
    [currentMonkey, map]
  end
  def parse("Operation: new = old * " <> number, [currentMonkey, map]) do
    [{startingItems}] = map[currentMonkey]
    map = put_in(map[currentMonkey], [{startingItems, "times", String.to_integer(number)}])
    [currentMonkey, map]
  end
  def parse("Operation: new = old + old", [currentMonkey, map]) do
    [{startingItems}] = map[currentMonkey]
    map = put_in(map[currentMonkey], [{startingItems, "plus", "self"}])
    [currentMonkey, map]
  end
  def parse("Operation: new = old + " <> number, [currentMonkey, map]) do
    [{startingItems}] = map[currentMonkey]
    map = put_in(map[currentMonkey], [{startingItems, "plus", String.to_integer(number)}])
    [currentMonkey, map]
  end
  def parse("Starting items: " <> numbers, [currentMonkey, map]) do
    array = numbers |> String.split(", ")
                    |> Enum.map(fn stringNum -> String.to_integer(stringNum)  end)
    map = put_in(map[currentMonkey], [{array}])
    [currentMonkey, map]
  end
  def parse("Monkey " <> <<number::binary-size(1)>> <> ":", [_, map]), do: [String.to_integer(number), put_in(map[String.to_integer(number)], [{}])]
  def parse(contents) do
    String.split(contents, "\n", trim: true) |> Enum.map(fn string -> String.trim(string) end)
                                             |> Enum.reduce([0,%{}], fn (string, output) -> parse(string, output) end)
                                             |> tl()
                                             |> hd()
  end

  def increaseWorry(startValue, "times", "self"), do: startValue * startValue
  def increaseWorry(startValue, "times", count), do: startValue * count
  def increaseWorry(startValue, "plus", "self"), do: startValue + startValue
  def increaseWorry(startValue, "plus", count), do: startValue + count

  def throwToMonkey(worryLevel, monkey, map) do
    [{startingItems, type, count, divisible, trueMonkey, falseMonkey}, callsCount] = map[monkey]
    put_in(map[monkey], [{Enum.concat(startingItems, [worryLevel]), type, count, divisible, trueMonkey, falseMonkey}, callsCount])
  end

  def handleItem([], _type, _count, _divisible, _trueMonkey, _falseMonkey, map), do: map
  def handleItem([head | tail], type, count, divisible, trueMonkey, falseMonkey, map) do
    worryLevel = trunc(Float.floor(increaseWorry(head, type, count) / 3, 0))
    if rem(worryLevel, divisible) == 0 do
      handleItem(tail, type, count, divisible, trueMonkey, falseMonkey, throwToMonkey(worryLevel, trueMonkey, map))
    else
      handleItem(tail, type, count, divisible, trueMonkey, falseMonkey, throwToMonkey(worryLevel, falseMonkey, map))
    end
  end

  @doc """
  Perform monkey turn

  ## Examples

      iex> Day11.monkeyTurn(0, %{0 => [{[], "times", 19, 23, 2, 3}, 0]})
      %{0 => [{[], "times", 19, 23, 2, 3}, 0]}
"""

  def monkeyTurn(currentMonkey, map) do
   [{startingItems, type, count, divisible, trueMonkey, falseMonkey}, callsCount] = map[currentMonkey]
    map = handleItem(startingItems, type, count, divisible, trueMonkey, falseMonkey, map)
    put_in(map[currentMonkey], [{[], type, count, divisible, trueMonkey, falseMonkey}, callsCount+length(startingItems)])
  end

  def inspections({_key, [_details, inspectCount]}) , do: inspectCount

  def part1(contents) do
    map = parse(contents)
    [highest, nextHighest | _tail] = 1..20 |> Enum.map(fn _ -> Map.keys(map) end)
                                           |> Enum.flat_map(fn x -> x end)
                                           |> Enum.reduce(map, fn (currentMonkey, map) -> monkeyTurn(currentMonkey, map) end)
                                           |> Enum.map(fn monkey -> inspections(monkey) end)
                                           |> Enum.sort()
                                           |> Enum.reverse()
    highest * nextHighest
  end

  def solve1 do
    {:ok, contents} = File.read("Day11.txt")
    part1(contents)
  end
end
