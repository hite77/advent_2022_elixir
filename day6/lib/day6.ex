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

  def findPositionOfFirstUniqueFourCharacters(<<string::binary-size(4)>> <> rest, count) do
    if containsDuplicate(string) do
      findPositionOfFirstUniqueFourCharacters(String.slice(string, 1, 3) <> rest, count + 1)
    else
      count
    end
  end

   @doc """
  Find position of first unique set of fourteen characters

  ## Examples

      iex> Day6.findPositionOfFirstUnique14Characters("mjqjpqmgbljsphdztnvjfqwrcgsmlb", 14)
      19
  """

  def findPositionOfFirstUnique14Characters(<<string::binary-size(14)>> <> rest, count) do
    if containsDuplicate(string) do
      findPositionOfFirstUnique14Characters(String.slice(string, 1, 13) <> rest, count + 1)
    else
      count
    end
  end

  @doc """
  Determine if duplicate within string of any length

      ## Examples

      iex> Day6.containsDuplicate("abcda")
      true

      iex> Day6.containsDuplicate("czdz")
      true

      iex> Day6.containsDuplicate("czd")
      false

  """

  def containsDuplicate(string) do
    string
      |> String.graphemes
      |> Enum.sort()
      |> Enum.chunk_by(fn arg -> arg end)
      |> findDuplicates()
  end

  def findDuplicates([head | _tail]) when length(head) > 1, do: true
  def findDuplicates([head | tail]) when length(head) == 1, do: findDuplicates(tail)
  def findDuplicates([]), do: false


  def solve1 do
    {:ok, contents} = File.read("day6.txt")
    findPositionOfFirstUniqueFourCharacters(contents, 4)
  end

  def solve2 do
    {:ok, contents} = File.read("day6.txt")
    findPositionOfFirstUnique14Characters(contents, 14)
  end
end
