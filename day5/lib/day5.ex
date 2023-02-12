defmodule Day5 do
  @moduledoc """
  Documentation for `Day5`.
  """

  def solve1 do
    {:ok, contents} = File.read("day5.txt")
    part1(contents)
  end

  def separate("", output), do: output
  def separate(item, []), do: [[item]]
  def separate(item, [[head]]), do: [[item, head]]
  def separate(item, [[head | tail]]) do
    if !String.contains?(item, "[") && !String.contains?(item, "move") do
      [[],[head | tail]]
    else
      [[item, head | tail]]
    end
  end
  def separate(item, [[],moves]), do: [[item], moves]
  def separate(item, [[crate],moves]), do: [[item, crate], moves]
  def separate(item, [[head | tail],moves]), do: [[item, head | tail], moves]

@doc """
  Convert Crates from string to map

  ## Examples

  Statement for no string, leave collection alone
  iex> Day5.convertCrates("", 1, %{})
  %{}

  non matching key will be added
  iex> Day5.convertCrates("[J]", 5, %{1 => ["[N]"], 2 => ["[D]"], 3 => ["[P]"]})
  %{1 => ["[N]"], 2 => ["[D]"], 3 => ["[P]"], 5 => ["[J]"]}


  adding a crate to empty map
  iex> Day5.convertCrates("[K]", 7, %{})
  %{7 => ["[K]"]}

  #cases for breaking a list down that has three columns.
  iex> Day5.convertCrates("[K] [J] [I]", 1, %{1 => ["[A]","[B]","[C]"], 2 => ["[H]"]})
  %{1 => ["[K]", "[A]", "[B]", "[C]"], 2 => ["[J]", "[H]"], 3 => ["[I]"]}

  #and case for second column crate "    [D]"
  iex> Day5.convertCrates("    [D]", 1, %{1 => ["[A]","[B]","[C]"], 2 => ["[H]"]})
  %{1 => ["[A]", "[B]", "[C]"], 2 => ["[D]", "[H]"]}

  Combines correctly
  iex> Day5.convertCrates("[J]", 2, %{1 => ["[N]"], 2 => ["[D]"], 3 => ["[P]"]})
  %{1 => ["[N]"], 2 => ["[J]", "[D]"], 3 => ["[P]"]}

  iex> Day5.convertCrates("[K]", 3, %{1 => ["[N]"], 2 => ["[D]"], 3 => ["[P]", "[R]", "[Z]"]})
  %{1 => ["[N]"], 2 => ["[D]"], 3 => ["[K]", "[P]", "[R]", "[Z]"]}

  iex> Day5.convertCrates("[A]", 1, %{1 => ["[N]", "[O]"], 2 => ["[D]"], 3 => ["[P]", "[R]", "[Z]"]})
  %{1 => ["[A]","[N]","[O]"], 2 => ["[D]"], 3 => ["[P]", "[R]","[Z]"]}

  ignores empty entry and returns existing map
  iex> Day5.convertCrates("   ", 1, %{})
  %{}

  """

  def convertCrates("", _column, crateMap), do: crateMap
  def convertCrates("   ", _column, crateMap), do: crateMap
  def convertCrates(crateToAdd, column, crateMap) when byte_size(crateToAdd) == 3 and is_map_key(crateMap, column) do
    [head | tail] = crateMap[column]
    put_in crateMap[column], [crateToAdd, head | tail]
  end

  def convertCrates(crateToAdd, column, crateMap) when byte_size(crateToAdd) == 3 and is_map_key(crateMap, column) == false, do: put_in crateMap[column], [crateToAdd]
  def convertCrates(cratesToAdd, column, crateMap) when byte_size(cratesToAdd) > 3 do
    {entry, newRemainder} = String.split_at(cratesToAdd, 4)
    trimmedEntry = String.trim(entry)
    convertCrates(newRemainder, column + 1, convertCrates(trimmedEntry, column, crateMap))
  end



  @doc """
  Perform move calls single move to move the indicated number of times

  ## Example

  iex> Day5.convertMove("move 9 from 14 to 8")
  {9, 14, 8}

  """

  def convertMove(moveString) do
    ["move " <> countString, unparsed] = String.split(moveString, " from ")
    count = String.to_integer(countString)
    [fromString, toString] = String.split(unparsed, " to ")
    from = String.to_integer(fromString)
    to = String.to_integer(toString)
    {count, from, to}
  end

  @doc """
  Perform move calls single move to move the indicated number of times

  ## Examples

  Zero moves will return same as input
  iex> Day5.performMove({0, 2, 1}, %{1 => ["[N]","[Z]"],2 => ["[D]","[C]","[M]"],3 => ["[P]"]})
  %{1 => ["[N]","[Z]"],2 => ["[D]","[C]","[M]"],3 => ["[P]"]}

  Move all three from column 2 to column 1
  iex> Day5.performMove({3, 2, 1}, %{1 => ["[N]","[Z]"],2 => ["[D]","[C]","[M]"],3 => ["[P]"]})
  %{1 => ["[M]", "[C]", "[D]", "[N]", "[Z]"], 2 => [], 3 => ["[P]"]}

  """

  def performMove({count, _from, _to }, output) when count == 0, do: output
  def performMove({count, from, to}, output) do
    performMove({count-1, from, to}, singleMove(output, from, to))
  end

   @doc """
  Single Move moves a crate from the from and puts it in to

  ## Examples

  Moving crate from 2 column to 1st column
  iex> Day5.singleMove(%{1 => ["[N]","[Z]"],2 => ["[D]","[C]","[M]"],3 => ["[P]"]}, 2, 1)
  %{1 => ["[D]", "[N]", "[Z]"], 2 => ["[C]", "[M]"], 3 => ["[P]"]}

  Move from 3 to 1 emptying 3rd column
  iex> Day5.singleMove(%{1 => ["[D]", "[N]", "[Z]"], 2 => ["[C]", "[M]"], 3 => ["[P]"]}, 3, 2)
  %{1 => ["[D]", "[N]", "[Z]"], 2 => ["[P]", "[C]", "[M]"], 3 => []}

  """

  def singleMove(output, from, to) do
    [head | tail] = output[from]
    output = put_in output[from], tail
    output = put_in output[to], [ head | output[to] ]
    output
  end

  @doc """
  Top Crate pulls the left most item

  ## Examples

  One item will return the letter in the crate.
  iex> Day5.topCrate({1, ["[A]"]})
  "A"

  More then one item will return the first letter in the column.
  iex> Day5.topCrate({1, ["[J]", "[C]", "[H]"]})
  "J"
  """
  def topCrate(crate) do
    {_, ["[" <> characterAndClosingBrace | _tail]} = crate
    "]" <> stripped = String.reverse(characterAndClosingBrace)
    stripped
  end

    @doc ~S"""
  Part 1 -- Parses contents for Crate locations at start, moves to perform
  It makes the moves, and then pulls the letters for top crate as answer

  ## Example

  One item will return the letter in the crate.
  iex> Day5.part1("    [D]\n[N] [C]\n[Z] [M] [P]\n 1   2   3\n\nmove 1 from 2 to 1\nmove 3 from 1 to 3\nmove 2 from 2 to 1\nmove 1 from 1 to 2\n")
  "CMZ"

  """

  def part1(contents) do
    [movesStrings, cratesString] = contents |> String.split("\n", trim: false)
                                            |> Enum.reduce([], fn (item, output) -> separate(item, output) end)

    crates = cratesString |> Enum.reduce(%{}, fn (string, crates) -> convertCrates(string, 1 ,crates) end)

    movesStrings |> Enum.reverse()
                 |> Enum.map(fn moveString -> convertMove(moveString) end)
                 |> Enum.reduce(crates, fn (move, output) -> performMove(move, output) end)
                 |> Enum.map(fn x -> Day5.topCrate(x) end)
                 |> Enum.join()
  end
end
