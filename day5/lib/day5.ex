defmodule Day5 do
  @moduledoc """
  Documentation for `Day5`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Day5.hello()
      :world

  """
  def hello do
    :world
  end


  def solve1 do
    {:ok, contents} = File.read("day5.txt")
    part1(contents)
  end

   #[head | tail] = sample[1]

    #sample = put_in sample[1], tail
    #sample = put_in sample[2], [ head | sample[2] ]

  def sample do
    sample2 = """
    [D]
[N] [C]
[Z] [M] [P]
 1   2   3

move 1 from 2 to 1
move 3 from 1 to 3
move 2 from 2 to 1
move 1 from 1 to 2
"""
    # sample |> String.split("\n", trim: false)
    # ["    [D]", "[N] [C]", "[Z] [M] [P]", " 1   2   3", "", "move 1 from 2 to 1",
    #      "move 3 from 1 to 3", "move 2 from 2 to 1", "move 1 from 1 to 2", ""]
    # get sample pulling moves and crates into separate objects.
  end

  def performMoves(moves, start) do
    Enum.reduce(moves, start, fn (move, output) -> performMove(move, output) end)
  end

  def performMove({0, _from, _to }, output) do
    output
  end

  def performMove({count, from, to}, output) do
    performMove({count-1, from, to}, singleMove(output, from, to))
  end

  def singleMove(output, from, to) do
    [head | tail] = output[from]
    output = put_in output[from], tail
    output = put_in output[to], [ head | output[to] ]
    output
  end

  def topCrates(crates) do
    Enum.join(Enum.map(crates, fn x -> Day5.topCrate(x) end))
  end

  def topCrate(crate) do
    {_, ["[" <> almostStripped | _tail]} = crate
    String.slice(almostStripped,0,1)
  end

  # document this
  # test this with sample text.
  def part1(contents) do
    contents |> String.split("\n", trim: false) |> String.split("", trim: true)
    # need to get the crates into map
    # need to get moves into tuples array

    # call perform moves
    # call topCrates on it --> will output letters
  end
end
