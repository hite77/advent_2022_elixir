defmodule Day5Test do
  use ExUnit.Case
  doctest Day5

  test "perform moves will move the pieces" do
    crates = %{
      1 => ["[N]","[Z]"],
      2 => ["[D]","[C]","[M]"],
      3 => ["[P]"]
    }

    afterFirstMove = %{
      1 => ["[D]","[N]","[Z]"],
      2 => ["[C]","[M]"],
      3 => ["[P]"]
    }

    afterSecondMove = %{
      1 => [],
      2 => ["[C]","[M]"],
      3 => ["[Z]","[N]","[D]","[P]"]
    }

    afterThirdMove = %{
      1 => ["[M]", "[C]"],
      2 => [],
      3 => ["[Z]","[N]","[D]","[P]"]
    }

    afterFourthMove = %{
      1 => ["[C]"],
      2 => ["[M]"],
      3 => ["[Z]","[N]","[D]","[P]"]
    }

    #move 1 from 2 to 1
    assert Day5.performMoves([{1, 2, 1}], crates) == afterFirstMove
    #move 3 from 1 to 3
    assert Day5.performMoves([{1, 2, 1},
                              {3, 1, 3}], crates) == afterSecondMove
    #move 2 from 2 to 1
    assert Day5.performMoves([{1, 2, 1},
                              {3, 1, 3},
                              {2, 2, 1}], crates) == afterThirdMove
    #move 1 from 1 to 2
    assert Day5.performMoves([{1, 2, 1},
                              {3, 1, 3},
                              {2, 2, 1},
                              {1, 1, 2}], crates) == afterFourthMove
  end

  test "Gets top crates answer" do
    afterFourthMove = %{
      1 => ["[C]"],
      2 => ["[M]"],
      3 => ["[Z]","[N]","[D]","[P]"]
    }

    assert afterFourthMove |> Day5.topCrates() == "CMZ"
  end

  #     [D]
  # [N] [C]
  # [Z] [M] [P]
  #  1   2   3   bottom

  # move 1 from 2 to 1
  # move 3 from 1 to 3
  # move 2 from 2 to 1
  # move 1 from 1 to 2

  # After all this the top crate will be CMZ

  # need to read the file in.....
  #build the crate positions (3 columns here, 9 for input)
  #positioning sideways should be parsed also may need to split at characters widths
  #empties should not be added in....

end
