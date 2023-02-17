defmodule Day8Test do
  use ExUnit.Case
  doctest Day8

  test "visibleTrees for edges" do
    map = %{"1,1" => 3, "2,1" => 0, "3,1" => 3, "4,1" => 7, "5,1" => 3,
            "1,2" => 2, "2,2" => 5, "3,2" => 5, "4,2" => 1, "5,2" => 2,
            "1,3" => 6, "2,3" => 5, "3,3" => 3, "4,3" => 3, "5,3" => 2,
            "1,4" => 3, "2,4" => 3, "3,4" => 5, "4,4" => 4, "5,4" => 9,
            "1,5" => 3, "2,5" => 5, "3,5" => 3, "4,5" => 9, "5,5" => 0
        }
    assert Day8.visibleTrees([1,1], map, 5, 5, 0) == 1
    assert Day8.visibleTrees([1,2], map, 5, 5, 0) == 1
    assert Day8.visibleTrees([1,3], map, 5, 5, 0) == 1
    assert Day8.visibleTrees([1,4], map, 5, 5, 0) == 1
    assert Day8.visibleTrees([1,5], map, 5, 5, 0) == 1

    assert Day8.visibleTrees([2,1], map, 5, 5, 0) == 1
    assert Day8.visibleTrees([2,5], map, 5, 5, 0) == 1
    assert Day8.visibleTrees([3,1], map, 5, 5, 0) == 1
    assert Day8.visibleTrees([3,5], map, 5, 5, 0) == 1
    assert Day8.visibleTrees([4,1], map, 5, 5, 0) == 1
    assert Day8.visibleTrees([4,5], map, 5, 5, 0) == 1

    assert Day8.visibleTrees([5,1], map, 5, 5, 0) == 1
    assert Day8.visibleTrees([5,2], map, 5, 5, 0) == 1
    assert Day8.visibleTrees([5,3], map, 5, 5, 0) == 1
    assert Day8.visibleTrees([5,4], map, 5, 5, 0) == 1
    assert Day8.visibleTrees([5,5], map, 5, 5, 0) == 1
  end

  test "visibleTrees for middle" do
    map = %{"1,1" => 3, "2,1" => 0, "3,1" => 3, "4,1" => 7, "5,1" => 3,
            "1,2" => 2, "2,2" => 5, "3,2" => 5, "4,2" => 1, "5,2" => 2,
            "1,3" => 6, "2,3" => 5, "3,3" => 3, "4,3" => 3, "5,3" => 2,
            "1,4" => 3, "2,4" => 3, "3,4" => 5, "4,4" => 4, "5,4" => 9,
            "1,5" => 3, "2,5" => 5, "3,5" => 3, "4,5" => 9, "5,5" => 0
          }
    assert Day8.visibleTrees([2,2], map, 5, 5, 0) == 1 # left and top
    assert Day8.visibleTrees([3,2], map, 5, 5, 0) == 1 # top and right
    assert Day8.visibleTrees([4,2], map, 5, 5, 0) == 0

    assert Day8.visibleTrees([2,3], map, 5, 5, 0) == 1 # right
    assert Day8.visibleTrees([3,3], map, 5, 5, 0) == 0
    assert Day8.visibleTrees([4,3], map, 5, 5, 0) == 1 # right

    assert Day8.visibleTrees([2,4], map, 5, 5, 0) == 0
    assert Day8.visibleTrees([3,4], map, 5, 5, 0) == 1 # bottom and left
    assert Day8.visibleTrees([4,4], map, 5, 5, 0) == 0
  end

  test "visibleTrees count visible trees" do
    map = %{"1,1" => 3, "2,1" => 0, "3,1" => 3, "4,1" => 7, "5,1" => 3,
            "1,2" => 2, "2,2" => 5, "3,2" => 5, "4,2" => 1, "5,2" => 2,
            "1,3" => 6, "2,3" => 5, "3,3" => 3, "4,3" => 3, "5,3" => 2,
            "1,4" => 3, "2,4" => 3, "3,4" => 5, "4,4" => 4, "5,4" => 9,
            "1,5" => 3, "2,5" => 5, "3,5" => 3, "4,5" => 9, "5,5" => 0
          }

    width = 5
    height = 5
    assert 1..width |> Enum.map(fn x -> 1..height |> Enum.map(fn y -> [x,y] end) end)
                    |> Enum.flat_map(fn x -> x end)
                    |> Enum.reduce(0, fn (treeLocation, output) ->  Day8.visibleTrees(treeLocation, map, width, height, output) end) == 21
  end


  test "parsing to map for trees" do
    [width, height, map] = Day8.parse("30373\n25512\n65332\n33549\n35390")
    assert width == 5
    assert height == 5
    assert map == %{"1,1" => 3, "2,1" => 0, "3,1" => 3, "4,1" => 7, "5,1" => 3,
                    "1,2" => 2, "2,2" => 5, "3,2" => 5, "4,2" => 1, "5,2" => 2,
                    "1,3" => 6, "2,3" => 5, "3,3" => 3, "4,3" => 3, "5,3" => 2,
                    "1,4" => 3, "2,4" => 3, "3,4" => 5, "4,4" => 4, "5,4" => 9,
                    "1,5" => 3, "2,5" => 5, "3,5" => 3, "4,5" => 9, "5,5" => 0
                  }
  end

  test "parsing another map for trees" do
    [width, height, map] = Day8.parse("303\n255")
    assert width == 3
    assert height == 2
    assert map == %{"1,1" => 3, "2,1" => 0, "3,1" => 3,
                    "1,2" => 2, "2,2" => 5, "3,2" => 5}
  end

  test "visibleDistanceArea for edges" do
    map = %{"1,1" => 3, "2,1" => 0, "3,1" => 3, "4,1" => 7, "5,1" => 3,
            "1,2" => 2, "2,2" => 5, "3,2" => 5, "4,2" => 1, "5,2" => 2,
            "1,3" => 6, "2,3" => 5, "3,3" => 3, "4,3" => 3, "5,3" => 2,
            "1,4" => 3, "2,4" => 3, "3,4" => 5, "4,4" => 4, "5,4" => 9,
            "1,5" => 3, "2,5" => 5, "3,5" => 3, "4,5" => 9, "5,5" => 0
        }
    assert Day8.visibleDistanceArea([1,1], map, 5, 5, 0) == 0
    assert Day8.visibleDistanceArea([1,2], map, 5, 5, 0) == 0
    assert Day8.visibleDistanceArea([1,3], map, 5, 5, 0) == 0
    assert Day8.visibleDistanceArea([1,4], map, 5, 5, 0) == 0
    assert Day8.visibleDistanceArea([1,5], map, 5, 5, 0) == 0

    assert Day8.visibleDistanceArea([2,1], map, 5, 5, 0) == 0
    assert Day8.visibleDistanceArea([2,5], map, 5, 5, 0) == 0
    assert Day8.visibleDistanceArea([3,1], map, 5, 5, 0) == 0
    assert Day8.visibleDistanceArea([3,5], map, 5, 5, 0) == 0
    assert Day8.visibleDistanceArea([4,1], map, 5, 5, 0) == 0
    assert Day8.visibleDistanceArea([4,5], map, 5, 5, 0) == 0

    assert Day8.visibleDistanceArea([5,1], map, 5, 5, 0) == 0
    assert Day8.visibleDistanceArea([5,2], map, 5, 5, 0) == 0
    assert Day8.visibleDistanceArea([5,3], map, 5, 5, 0) == 0
    assert Day8.visibleDistanceArea([5,4], map, 5, 5, 0) == 0
    assert Day8.visibleDistanceArea([5,5], map, 5, 5, 0) == 0
  end

  test "visibleDistanceArea for middle" do
    map = %{"1,1" => 3, "2,1" => 0, "3,1" => 3, "4,1" => 7, "5,1" => 3,
            "1,2" => 2, "2,2" => 5, "3,2" => 5, "4,2" => 1, "5,2" => 2,
            "1,3" => 6, "2,3" => 5, "3,3" => 3, "4,3" => 3, "5,3" => 2,
            "1,4" => 3, "2,4" => 3, "3,4" => 5, "4,4" => 4, "5,4" => 9,
            "1,5" => 3, "2,5" => 5, "3,5" => 3, "4,5" => 9, "5,5" => 0
          }
    assert Day8.visibleDistanceArea([2,2], map, 5, 5, 0) == 1 #up 1, left 1, right 1, down 1 *= 1
    assert Day8.visibleDistanceArea([3,2], map, 5, 5, 0) == 4 #up 1, left 1, right 2, down 2 *= 4 ==> right and down working
    assert Day8.visibleDistanceArea([4,2], map, 5, 5, 0) == 1 #up 1, left 1, right 1, down 1 *= 1

    assert Day8.visibleDistanceArea([2,3], map, 5, 5, 0) == 6 #up 1, left 1, right 3, down 2 *= 6 ==> right and down working
    assert Day8.visibleDistanceArea([3,3], map, 5, 5, 0) == 1 #up 1, left 1, right 1, down 1 *= 1
    assert Day8.visibleDistanceArea([4,3], map, 5, 5, 0) == 2 #up 2, left 1, right 1, down 1 *= 2 ==> up working

    assert Day8.visibleDistanceArea([2,4], map, 5, 5, 0) == 1 #up 1, left 1, right 1, down 1 *= 1
    assert Day8.visibleDistanceArea([3,4], map, 5, 5, 0) == 8 #up 2, left 2, right 2, down 1 *= 8 ==> up, left, right working
    assert Day8.visibleDistanceArea([4,4], map, 5, 5, 0) == 3 #up 3, left 1, right 1, down 1 *= 3 ==> up working
  end

  test "parts/solutions with my dataset" do
    assert Day8.part1("30373\n25512\n65332\n33549\n35390") == 21
    assert Day8.part2("30373\n25512\n65332\n33549\n35390") == 8
    assert Day8.solve1 == 1794
    assert Day8.solve2 == 199272
  end
end
