defmodule Day14 do
  @moduledoc """
  Documentation for `Day14`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Day14.hello()
      :world

  """
  def hello do
    :world
  end

  def solve1 do
    {:ok, contents} = File.read("input.txt")
    part1(contents)
  end

  def part1(contents) do
    # parse into hash map
    # continue calling sand -> updating hashmap
    # exit condition is sand falling past
    # count should be result.
  end
end
