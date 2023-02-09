defmodule Day4 do
  @moduledoc """
  Documentation for `Day4`.
  """

   @doc """
  Split coordinates

  ## Examples

      iex> Day4.splitCoordinates("6-6,4-6")
      [6, 6, 4, 6]

  """
  def splitCoordinates(line) do
    [first, second] = String.split(line, ",")
    [[startFirst, endFirst], [startSecond, endSecond]] = [String.split(first, "-"), String.split(second, "-")]
    [String.to_integer(startFirst), String.to_integer(endFirst), String.to_integer(startSecond), String.to_integer(endSecond)]
  end

   @doc """
  Includes coordinates

  ## Examples

      iex> Day4.includes([6,6,4,6])
      1

      iex> Day4.includes([2,8,3,7])
      1

      iex> Day4.includes([2,4,6,8])
      0

      iex> Day4.includes([2,6,6,8])
      0


  """

  def includes([startFirst, endFirst, startSecond, endSecond]) when startFirst >= startSecond and endFirst <= endSecond, do: 1
  def includes([startFirst, endFirst, startSecond, endSecond]) when startFirst <= startSecond and endFirst >= endSecond, do: 1
  def includes(_), do: 0

  @doc """
  Includes any coordinates

  ## Examples

      iex> Day4.includesAny([6,6,4,6])
      1

      iex> Day4.includesAny([2,8,3,7])
      1

      iex> Day4.includesAny([2,4,6,8])
      0

      iex> Day4.includesAny([2,6,6,8])
      1

  """

  def includesAny([_, endFirst, startSecond, endSecond]) when endFirst in startSecond..endSecond, do: 1
  def includesAny([startFirst, _, startSecond, endSecond]) when startFirst in startSecond..endSecond, do: 1
  def includesAny([startFirst, endFirst, _, endSecond]) when endSecond in startFirst..endFirst, do: 1
  def includesAny([startFirst, endFirst, startSecond, _]) when startSecond in startFirst..endFirst, do: 1
  def includesAny(_), do: 0

  def part1() do
    {:ok, contents} = File.read("day4.txt")
    contents |> String.split("\n", trim: false)
             |> Enum.map(fn line -> splitCoordinates(line) end)
             |> Enum.map(fn coords -> includes(coords) end)
             |> Enum.sum()
  end

  def part2() do
    {:ok, contents} = File.read("day4.txt")
    contents |> String.split("\n", trim: false)
             |> Enum.map(fn line -> splitCoordinates(line) end)
             |> Enum.map(fn coords -> includesAny(coords) end)
             |> Enum.sum()
  end
end
