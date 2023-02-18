defmodule Day9 do
  @moduledoc """
  Documentation for `Day9`.
  """

  @doc """
  Put count of coordinate in map or update count

  ## Examples

      iex> Day9.updateMap(1,5, %{})
      %{"1,5" => 1}

      iex> Day9.updateMap(3,8, %{"3,8" => 5})
      %{"3,8" => 6}

  """
  def updateMap(x, y, map) do
    if is_map_key(map, "#{x},#{y}") do
      %{map | "#{x},#{y}" => map["#{x},#{y}"] + 1}
    else
      Map.put(map, "#{x},#{y}", 1)
    end
  end

  @doc """
  Distance between

  ## Examples

      iex> Day9.distanceBetween(-5, -4)
      1

      iex> Day9.distanceBetween(-4, -5)
      1

      iex> Day9.distanceBetween(-4, 5)
      9

      iex> Day9.distanceBetween(5, -5)
      10

      iex> Day9.distanceBetween(-1, 1)
      2

      iex> Day9.distanceBetween(1, -1)
      2
  """
  def distanceBetween(first, second) do
    #within 2 -- both neg, both positive, 1 and -1 should be 2
    #find bigger number? then subtract smaller from bigger?
    if first > second do
      abs(first-second)
    else
      abs(second-first)
    end

  end

  #TODO: document based on subset of tests
  def performMove("R", [leadx, leady, followx, followy, map]) do
    distancex = distanceBetween(leadx+1,followx)
    distancey = distanceBetween(leady,followy)
    cond do
      (distancex + distancey <= 1) or # only one away means left/right/top/bottom
      (distancex == 1 and distancey == 1) -> [leadx+1, leady, followx, followy, map]
      followy > leady -> [leadx+1, leady, followx+1, followy-1, updateMap(followx+1, followy-1, map) ]
      followy < leady -> [leadx+1, leady, followx+1, followy+1, updateMap(followx+1, followy+1, map) ]
      true            -> [leadx+1, leady, followx+1, followy  , updateMap(followx+1, followy  , map) ]
    end
  end
  def performMove("L", [leadx, leady, followx, followy, map]) do
    distancex = distanceBetween(leadx-1,followx)
    distancey = distanceBetween(leady,followy)
    cond do
      (distancex + distancey <= 1) or # only one away means left/right/top/bottom
      (distancex == 1 and distancey == 1) -> [leadx-1, leady, followx, followy, map]
      followy > leady -> [leadx-1, leady, followx-1, followy-1, updateMap(followx-1, followy-1, map) ]
      followy < leady -> [leadx-1, leady, followx-1, followy+1, updateMap(followx-1, followy+1, map) ]
      true            -> [leadx-1, leady, followx-1, followy  , updateMap(followx-1, followy  , map) ]
    end
  end
  def performMove("U", [leadx, leady, followx, followy, map]) do
    distancex = distanceBetween(leadx,followx)
    distancey = distanceBetween(leady+1,followy)
    cond do
      (distancex + distancey <= 1) or # only one away means left/right/top/bottom
      (distancex == 1 and distancey == 1) -> [leadx, leady+1, followx, followy, map]
      followx > leadx -> [leadx, leady+1, followx-1, followy+1, updateMap(followx-1, followy+1, map) ]
      followx < leadx -> [leadx, leady+1, followx+1, followy+1, updateMap(followx+1, followy+1, map) ]
      true            -> [leadx, leady+1, followx  , followy+1, updateMap(followx  , followy+1, map) ]
    end
  end
  def performMove("D", [leadx, leady, followx, followy, map]) do
    distancex = distanceBetween(leadx,followx)
    distancey = distanceBetween(leady-1,followy)
    cond do
      (distancex + distancey <= 1) or # only one away means left/right/top/bottom
      (distancex == 1 and distancey == 1) -> [leadx, leady-1, followx, followy, map]
      followx > leadx -> [leadx, leady-1, followx-1, followy-1, updateMap(followx-1, followy-1, map) ]
      followx < leadx -> [leadx, leady-1, followx+1, followy-1, updateMap(followx+1, followy-1, map) ]
      true            -> [leadx, leady-1, followx  , followy-1, updateMap(followx  , followy-1, map) ]
    end
  end

  #TODO: document based on subset of tests
  def unwrapMoves(_character, 1, output), do: output
  def unwrapMoves(character, count, [head | tail]), do: unwrapMoves(character, count-1, [character, head | tail])
  def unwrapMoves(<<character::binary-size(1)>> <> " " <> count), do: unwrapMoves(character, String.to_integer(count), [character])

  #TODO: document with example
  def part1(contents) do
    [_leadx, _leady, _followx, _followy, map] = contents |> Enum.map(fn move -> unwrapMoves(move) end)
                                                         |> Enum.flat_map(fn move -> move end)
                                                         |> Enum.reduce([0,0,0,0, %{"0,0" => 1}], fn (move, data) -> performMove(move, data) end)
    map |> Map.keys()
        |> length()
  end

  def solve1 do
    {:ok, contents} = File.read("day9.txt")
    part1(String.split(contents,"\n"))
  end
end
