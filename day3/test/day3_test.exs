defmodule Day3Test do
  use ExUnit.Case
  doctest Day3

  # each letter case sensitive represents an item, first half is first compartment
  # look for identical items in both halves
  # common between the two... could be duplicates in first or second half
  # a-z 1-26 A-Z 27-52
  # sum up values....

  test "splits strings" do
    assert Day3.halve("vJrwpWtwJgWrhcsFMMfFFhFp") == {"vJrwpWtwJgWr", "hcsFMMfFFhFp"}
    assert Day3.halve("jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL") == {"jqHRNqRjqzjGDLGL", "rsFMfFZSrLrFZsSL"}
    assert Day3.halve("PmmdzqPrVvPwwTWBwg") == {"PmmdzqPrV", "vPwwTWBwg"}
    assert Day3.halve("wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn") == {"wMqvLMZHhHMvwLH", "jbvcjnnSBnvTQFn"}
    assert Day3.halve("ttgJtRGJQctTZtZT") == {"ttgJtRGJ", "QctTZtZT"}
    assert Day3.halve("CrZsJsPPZsGzwwsLwLmpwMDw") == {"CrZsJsPPZsGz", "wwsLwLmpwMDw"}
  end

  test "common letter" do
    assert Day3.commonLetter({"vJrwpWtwJgWr", "hcsFMMfFFhFp"}) == "p"
    assert Day3.commonLetter({"jqHRNqRjqzjGDLGL", "rsFMfFZSrLrFZsSL"}) == "L"
    assert Day3.commonLetter({"PmmdzqPrV", "vPwwTWBwg"}) == "P"
    assert Day3.commonLetter({"wMqvLMZHhHMvwLH", "jbvcjnnSBnvTQFn"}) == "v"
    assert Day3.commonLetter({"ttgJtRGJ", "QctTZtZT"}) == "t"
    assert Day3.commonLetter({"CrZsJsPPZsGz", "wwsLwLmpwMDw"}) == "s"
  end

  test "point for letter" do
    assert Day3.pointForLetter("p") == 16
    assert Day3.pointForLetter("L") == 38
    assert Day3.pointForLetter("P") == 42
    assert Day3.pointForLetter("v") == 22
    assert Day3.pointForLetter("t") == 20
    assert Day3.pointForLetter("s") == 19
  end

end
