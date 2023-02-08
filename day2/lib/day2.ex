defmodule Day2 do
  @moduledoc """
  Documentation for `Day2`.
  """

# A for Rock
# B for Paper
# C for Scissors

# X for Rock 1
# Y for Paper 2
# Z for Scissors 3

#score for round is shape
#1 for Rock,
#2 for Paper,
#3 for scissors

#0 for lost, 3 if draw, 6 if you won

# Rock defeats Scissors,
# Scissors defeats Paper, and
# Paper defeats Rock.
# If both players choose the same shape, the round instead ends in
# a draw.
# 10649 wrong too low...
# 10488 wrong too low...
# 11226 wrong..... five minutes...


  @doc """
  roundPoint() returns points for round.

  ## Examples

      iex> Day2.roundPoint("A X")
      4

  """
  def roundPoint(input) do
    case input do
      #lookup's to string of two values split on space...
      #second function to two numbers...
      "A X" -> 1 + 3 # rock and rock draw
      "A Y" -> 2 + 6 # rock and paper win*
      "A Z" -> 3 + 0 # rock and scissors loss*
      "B X" -> 1 + 0 # paper and rock loss
      "B Y" -> 2 + 3 # paper and paper draw
      "B Z" -> 3 + 6 # paper and scissors win
      "C X" -> 1 + 6 # scissors and rock win
      "C Y" -> 2 + 0 # scissors and paper loss
      "C Z" -> 3 + 3 # scissors and scissors draw
      "" -> 0
    end
  end

  @doc """
  toAtoms() returns atom version of characters

  ## Examples

      iex> Day2.toAtoms("A X")
      [:A, :X]

  """
  def toAtoms(""), do: ""
  def toAtoms(item) do
    [theirShape, myShape] = String.split(item, " ")
    [String.to_atom(theirShape), String.to_atom(myShape)]
  end

  def pointsForPart2([:A, :X]), do: 3
  def pointsForPart2([:A, :Y]), do: 4
  def pointsForPart2([:A, :Z]), do: 8
  def pointsForPart2([:B, :X]), do: 1
  def pointsForPart2([:B, :Y]), do: 5
  def pointsForPart2([:B, :Z]), do: 9
  def pointsForPart2([:C, :X]), do: 2
  def pointsForPart2([:C, :Y]), do: 6
  def pointsForPart2([:C, :Z]), do: 7
  def pointsForPart2(""), do: 0

  def part1() do
    {:ok, contents} = File.read("day2.txt")
    contents |> String.split("\n", trim: false)
             |> Enum.map(fn round_to_score -> roundPoint(round_to_score) end)
             |> Enum.sum()
  end

  def part2() do
    {:ok, contents} = File.read("day2.txt")
    contents |> String.split("\n", trim: false)
             |> Enum.map(fn x -> toAtoms(x) end)
             |> Enum.map(fn atom -> pointsForPart2(atom) end)
             |> Enum.sum()
  end
end
