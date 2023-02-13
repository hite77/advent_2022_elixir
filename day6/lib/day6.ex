defmodule Day6 do
  @moduledoc """
  Documentation for `Day6`.
  """

  @doc """
  Find position of first unique set of four characters

  ## Examples

      iex> Day6.findPositionOfFirstUniqueFourCharacters("abcd", 4)
      4

      iex> Day6.findPositionOfFirstUniqueFourCharacters("abcad", 4)
      5

      iex> Day6.findPositionOfFirstUniqueFourCharacters("mjqjpqmgbljsphdztnvjfqwrcgsmlb", 4)
      7
  """

  def findPositionOfFirstUniqueFourCharacters(<<first::binary-size(1)>> <>
  <<second::binary-size(1)>> <>
  <<third::binary-size(1)>> <>
  <<fourth::binary-size(1)>> <> _rest, count) when first != second and first != third and first != fourth and second != third and second != fourth and third != fourth, do: count
  def findPositionOfFirstUniqueFourCharacters(<<_first::binary-size(1)>> <>
  <<second::binary-size(1)>> <>
  <<third::binary-size(1)>> <>
  <<fourth::binary-size(1)>> <> rest, count), do: findPositionOfFirstUniqueFourCharacters(second <> third <> fourth <> rest, count + 1)

  def solve1 do
    {:ok, contents} = File.read("day6.txt")
    findPositionOfFirstUniqueFourCharacters(contents, 4)
  end
end
