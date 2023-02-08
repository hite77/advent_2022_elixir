defmodule Day3 do
  @moduledoc """
  Documentation for `Day3`.
  Items in rucksack.
  """

  @doc """
  Halve a string.

  ## Examples

      iex> Day3.halve("foobar")
      {"foo", "bar"}

  """

  def halve(string) do
    splitpoint = round(String.length(string)/2)
    String.split_at(string, splitpoint)
  end

   @doc """
  If character is in second string return it
  Once output is set return that character no matter what

  ## Examples

      iex> Day3.characterContained("f", "foobar", "")
      "f"

      This one demonstrates output but it would likely be f.

      iex> Day3.characterContained("f", "foobaf", "z")
      "z"

  """

  def characterContained(character, second , "") do
    if second =~ character do
      character
    else
      ""
    end
  end
  def characterContained(_, _, output), do: output

   @doc """
  Get points for letters

  ## Examples

      iex> Day3.pointForLetter("a")
      1

      iex> Day3.pointForLetter("z")
      26

      iex> Day3.pointForLetter("A")
      27

      iex> Day3.pointForLetter("Z")
      52

  """

  def pointForLetter(letter) do
    <<v::utf8>> = letter
    case v do
      x when x in ?a..?z -> v - ?a + 1
      x when x in ?A..?Z -> v - ?A + 27
    end
  end

  @doc """
  Common letter between both sides.

  ## Examples

      iex> Day3.commonLetter({"abcf", "foof"})
      "f"

  """

  def commonLetter({first, second}) do
    list = String.graphemes(first)
    Enum.reduce(list, "", fn (character, output) -> characterContained(character, second, output) end)
  end

  def part1() do
    {:ok, contents} = File.read("day3.txt")
    contents |> String.split("\n", trim: false)
             |> Enum.map(fn pack -> halve(pack) end)
             |> Enum.map(fn pockets -> commonLetter(pockets) end)
             |> Enum.map(fn letter -> pointForLetter(letter) end)
             |> Enum.sum()
  end
end
