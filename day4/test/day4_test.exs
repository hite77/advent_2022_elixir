defmodule Day4Test do
  use ExUnit.Case
  doctest Day4

  test "split" do
    assert Day4.splitCoordinates("2-4,6-8") == [2,4,6,8]
  end

  test "fully includes ranges" do
    assert Day4.includes([2,4,6,8]) == 0
    assert Day4.includes([2,3,4,5]) == 0
    assert Day4.includes([5,7,7,9]) == 0
    assert Day4.includes([2,8,3,7]) == 1
    assert Day4.includes([6,6,4,6]) == 1
    assert Day4.includes([2,6,4,8]) == 0
  end
end
