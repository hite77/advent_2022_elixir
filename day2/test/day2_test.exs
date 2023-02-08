defmodule Day2Test do
  use ExUnit.Case
  doctest Day2

  #"A X" -> 1 + 3 # rock and rock draw
  # A for Rock
# B for Paper
# C for Scissors

# X for Rock 1
# Y for Paper 2
# Z for Scissors 3

#0 for lost, 3 if draw, 6 if you won

# Rock defeats Scissors,
# Scissors defeats Paper, and
# Paper defeats Rock.
  test "rock paper tests" do
    assert Day2.roundPoint("A X") == 1 + 3
    assert Day2.roundPoint("A Y") == 2 + 6
    assert Day2.roundPoint("A Z") == 3 + 0

    assert Day2.roundPoint("B X") == 1 + 0
    assert Day2.roundPoint("B Y") == 2 + 3
    assert Day2.roundPoint("B Z") == 3 + 6

    assert Day2.roundPoint("C X") == 1 + 6
    assert Day2.roundPoint("C Y") == 2 + 0
    assert Day2.roundPoint("C Z") == 3 + 3

    assert Day2.roundPoint("") == 0
  end

  test "part 1" do
    assert Day2.part1() == 12276
  end

  # test the too atom

  # X means lose (0 + shape)
  # Y means draw (3 + shape)
  # Z means win  (6 + shape)
  test "points for part2" do
    #9899 wrong answer -- too low
    assert Day2.pointsForPart2([:A, :X]) == 0 + 3 # lose with rock
    assert Day2.pointsForPart2([:A, :Y]) == 3 + 1 # draw with rock
    assert Day2.pointsForPart2([:A, :Z]) == 6 + 2 # win with rock

    assert Day2.pointsForPart2([:B, :X]) == 0 + 1 # lose with paper
    assert Day2.pointsForPart2([:B, :Y]) == 3 + 2 # draw with paper
    assert Day2.pointsForPart2([:B, :Z]) == 6 + 3 # win with paper

    assert Day2.pointsForPart2([:C, :X]) == 0 + 2 # lose with scissors
    assert Day2.pointsForPart2([:C, :Y]) == 3 + 3 # draw with scissors
    assert Day2.pointsForPart2([:C, :Z]) == 6 + 1 # win with scissors

    assert Day2.pointsForPart2("") == 0
  end

  #correct answer is 9975.....
end
