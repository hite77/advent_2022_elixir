defmodule Day11 do
  @moduledoc """
  Documentation for `Day11`.
  """

  @doc """
  Parses input into map

  ## Examples

      iex> Day11.parse("Monkey 4:", [3, %{3 => [{}, 0]}, []])
      [4, %{3 => [{}, 0], 4 => [{}]}, []]

      iex> Day11.parse("Starting items: 79, 98", [4, %{4 => [{}]}, []])
      [4, %{4 => [{[79,98]}]}, []]

      iex> Day11.parse("Operation: new = old * 11", [4, %{4 => [{[79,98]}]}, []])
      [4, %{4 => [{[79,98],"times", 11}]}, []]

      iex> Day11.parse("Operation: new = old + 14", [4, %{4 => [{[79,98]}]}, []])
      [4, %{4 => [{[79,98],"plus", 14}]}, []]

      iex> Day11.parse("Operation: new = old * old", [4, %{4 => [{[79,98]}]}, []])
      [4, %{4 => [{[79,98],"times", "self"}]}, []]

      iex> Day11.parse("Operation: new = old + old", [4, %{4 => [{[79,98]}]}, []])
      [4, %{4 => [{[79,98],"plus", "self"}]}, []]

      iex> Day11.parse("Test: divisible by 5", [4, %{4 => [{[79,98],"plus", "self"}]}, [6]])
      [4, %{4 => [{[79,98],"plus", "self", 5}]}, [5, 6]]

      iex> Day11.parse("If true: throw to monkey 23", [4, %{4 => [{[79,98],"plus", "self", 5}]}, [5]])
      [4, %{4 => [{[79,98],"plus", "self", 5, 23}]}, [5]]

      iex> Day11.parse("If false: throw to monkey 42", [4, %{4 => [{[79,98],"plus", "self", 5, 23}]}, [4]])
      [4, %{4 => [{[79,98],"plus", "self", 5, 23, 42}, 0]}, [4]]

  """
  def parse("If false: throw to monkey " <> number, [currentMonkey, map, divisors]) do
    [{startingItems, type, count, divisible, trueMonkey}] = map[currentMonkey]
    map = put_in(map[currentMonkey], [{startingItems, type, count, divisible, trueMonkey, String.to_integer(number)} , 0])
    [currentMonkey, map, divisors]
  end
  def parse("If true: throw to monkey " <> number, [currentMonkey, map, divisors]) do
    [{startingItems, type, count, divisible}] = map[currentMonkey]
    map = put_in(map[currentMonkey], [{startingItems, type, count, divisible, String.to_integer(number)}])
    [currentMonkey, map, divisors]
  end
  def parse("Test: divisible by " <> number, [currentMonkey, map, [head | tail]]) do
    [{startingItems, type, count}] = map[currentMonkey]
    divideBy = String.to_integer(number)
    map = put_in(map[currentMonkey], [{startingItems, type, count, divideBy}])
    [currentMonkey, map, [divideBy, head | tail]]
  end
  def parse("Test: divisible by " <> number, [currentMonkey, map, []]) do
    [{startingItems, type, count}] = map[currentMonkey]
    divideBy = String.to_integer(number)
    map = put_in(map[currentMonkey], [{startingItems, type, count, divideBy}])
    [currentMonkey, map, [divideBy]]
  end
  def parse("Operation: new = old * old", [currentMonkey, map, divisors]) do
    [{startingItems}] = map[currentMonkey]
    map = put_in(map[currentMonkey], [{startingItems, "times", "self"}])
    [currentMonkey, map, divisors]
  end
  def parse("Operation: new = old * " <> number, [currentMonkey, map, divisors]) do
    [{startingItems}] = map[currentMonkey]
    map = put_in(map[currentMonkey], [{startingItems, "times", String.to_integer(number)}])
    [currentMonkey, map, divisors]
  end
  def parse("Operation: new = old + old", [currentMonkey, map, divisors]) do
    [{startingItems}] = map[currentMonkey]
    map = put_in(map[currentMonkey], [{startingItems, "plus", "self"}])
    [currentMonkey, map, divisors]
  end
  def parse("Operation: new = old + " <> number, [currentMonkey, map, divisors]) do
    [{startingItems}] = map[currentMonkey]
    map = put_in(map[currentMonkey], [{startingItems, "plus", String.to_integer(number)}])
    [currentMonkey, map, divisors]
  end
  def parse("Starting items: " <> numbers, [currentMonkey, map, divisors]) do
    array = numbers |> String.split(", ")
                    |> Enum.map(fn stringNum -> String.to_integer(stringNum)  end)
    map = put_in(map[currentMonkey], [{array}])
    [currentMonkey, map, divisors]
  end
  def parse("Monkey " <> <<number::binary-size(1)>> <> ":", [_, map, divisors]), do: [String.to_integer(number), put_in(map[String.to_integer(number)], [{}]), divisors]
  def parse(contents) do
    [_currentMonkey, map, divisors] = String.split(contents, "\n", trim: true) |> Enum.map(fn string -> String.trim(string) end)
                                                                               |> Enum.reduce([0,%{},[]], fn (string, output) -> parse(string, output) end)
    [map, divisors]
  end

  def increaseWorry(startValue, "times", "self"), do: startValue * startValue
  def increaseWorry(startValue, "times", count), do: startValue * count
  def increaseWorry(startValue, "plus", "self"), do: startValue + startValue
  def increaseWorry(startValue, "plus", count), do: startValue + count

  def throwToMonkey(worryLevel, monkey, [{[], type, count, divisible, trueMonkey, falseMonkey}, callsCount], map) do
    put_in(map[monkey], [{[worryLevel], type, count, divisible, trueMonkey, falseMonkey}, callsCount])
  end
  def throwToMonkey(worryLevel, monkey, [{[head | tail], type, count, divisible, trueMonkey, falseMonkey}, callsCount], map) do
    put_in(map[monkey], [{[worryLevel, head | tail], type, count, divisible, trueMonkey, falseMonkey}, callsCount])
  end


  def decreaseWorry(worryLevel, divisors) do
    mod = divisors |> Enum.reduce(1, fn (divisor, output) -> divisor * output end)
    trunc(rem(worryLevel, mod))
  end

  def handleItem([], _type, _count, _divisible, _trueMonkey, _falseMonkey, map, _divideBy, _divisors), do: map
  def handleItem([head | tail], type, count, divisible, trueMonkey, falseMonkey, map, 1, divisors) do
    worryLevel = decreaseWorry(increaseWorry(head, type, count), divisors)
    if rem(worryLevel, divisible) == 0 do
      handleItem(tail, type, count, divisible, trueMonkey, falseMonkey, throwToMonkey(worryLevel, trueMonkey, map[trueMonkey], map), 1, divisors)
    else
      handleItem(tail, type, count, divisible, trueMonkey, falseMonkey, throwToMonkey(worryLevel, falseMonkey, map[falseMonkey], map), 1, divisors)
    end
  end
  def handleItem([head | tail], type, count, divisible, trueMonkey, falseMonkey, map, 3, divisors) do
    worryLevel = trunc(Float.floor(increaseWorry(head, type, count) / 3, 0))
    if rem(worryLevel, divisible) == 0 do
      handleItem(tail, type, count, divisible, trueMonkey, falseMonkey, throwToMonkey(worryLevel, trueMonkey, map[trueMonkey], map), 3, divisors)
    else
      handleItem(tail, type, count, divisible, trueMonkey, falseMonkey, throwToMonkey(worryLevel, falseMonkey, map[falseMonkey], map), 3, divisors)
    end
  end

  @doc """
  Perform monkey turn

  ## Examples

      iex> Day11.monkeyTurn([0], %{0 => [{[], "times", 19, 23, 2, 3}, 0]}, 3, [])
      %{0 => [{[], "times", 19, 23, 2, 3}, 0]}
"""

  def monkeyTurn([], map, _divideBy, _divisors), do: map
  def monkeyTurn([head | tail], map, divideBy, divisors) do
   [{startingItems, type, count, divisible, trueMonkey, falseMonkey}, callsCount] = map[head]
    map = handleItem(startingItems, type, count, divisible, trueMonkey, falseMonkey, map, divideBy, divisors)
    map = put_in(map[head], [{[], type, count, divisible, trueMonkey, falseMonkey}, callsCount+length(startingItems)])
    monkeyTurn(tail, map, divideBy, divisors)
  end

  def inspections({_key, [_details, inspectCount]}) , do: inspectCount

  def part1(contents) do
    [map, divisors] = parse(contents)
    [highest, nextHighest | _tail] =  1..20 |> Enum.map(fn _ -> Map.keys(map) end)
                                            |> Enum.flat_map(fn x -> x end)
                                            |> monkeyTurn(map, 3, divisors)
                                            |> Enum.map(fn monkey -> inspections(monkey) end)
                                            |> Enum.sort()
                                            |> Enum.reverse()
    highest * nextHighest
  end

  def part2(contents) do
    [map, divisors] = parse(contents)
    biggerRange = 1..10000
    [highest, nextHighest | _tail] = biggerRange |> Enum.map(fn _ -> Map.keys(map) end)
                                                 |> Enum.flat_map(fn x -> x end)
                                                 |> monkeyTurn(map, 1, divisors)
                                                 |> Enum.map(fn monkey -> inspections(monkey) end)
                                                 |> Enum.sort()
                                                 |> Enum.reverse()
    highest * nextHighest
  end
  def solve1 do
    {:ok, contents} = File.read("Day11.txt")
    part1(contents)
  end
  def solve2 do
    {:ok, contents} = File.read("Day11.txt")
    part2(contents)
  end
end
