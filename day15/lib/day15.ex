defmodule Day15 do
  @moduledoc """
  Documentation for `Day15`.
  """

  def solve1 do
    {:ok, contents} = File.read("input.txt")
    part1(contents)
  end

  def part1(contents) do
    parse(contents)
  end

  def parseline(line) do
    split = String.split(line,": closest beacon is at x=")
    first = split |> hd()
                  |> String.split("Sensor at x=")
                  |> tl()
                  |> hd()
                  |> String.split(", y=")
                  |> Enum.map(fn i -> String.to_integer(i) end)
    second = split |> tl()
                   |> hd()
                   |> String.split(", y=")
                   |> Enum.map(fn i -> String.to_integer(i) end)
    [first,second]
  end

  @doc """
  Parse text to coords

  ## Examples

      iex> Day15.parse("Sensor at x=2, y=18: closest beacon is at x=-2, y=15")
      [[[2, 18], [-2, 15]]]

  """
  def parse(contents) do
    contents |> String.split("\n", trim: true)
             |> Enum.map(fn line -> parseline(line) end)
  end
end
