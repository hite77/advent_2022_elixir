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
    # should be able to refactor to move head and have one reducer to find tail positions
    contents |> Enum.map(fn move -> unwrapMoves(move) end)
                                                         |> Enum.flat_map(fn move -> move end)
                                                         |> Enum.reduce([0,0,0,0, %{"0,0" => 1}], fn (move, data) -> performMove(move, data) end)
                                                         |> Enum.reverse()
                                                         |> hd()
                                                         |> Map.keys()
                                                         |> length()
  end

  def solve1 do
    {:ok, contents} = File.read("day9.txt")
    part1(String.split(contents,"\n"))
  end

  @doc """
  Move head according to move

  ## Examples

      iex> Day9.moveHead("R", [0,0, []])
      [1,0, [[1, 0]]]

      iex> Day9.moveHead("R", [1,0, [[1, 0]]])
      [2,0, [[2,0], [1, 0]]]

      iex> Day9.moveHead("R", [2,0, [[2,0] , [1, 0]]])
      [3,0, [[3,0],[2,0], [1, 0]]]

      iex> Day9.moveHead("L", [0,0, []])
      [-1,0, [[-1, 0]]]

      iex> Day9.moveHead("L", [-1,0, [[-1, 0]]])
      [-2,0, [[-2, 0], [-1, 0]]]

      iex> Day9.moveHead("U", [0,0, []])
      [0,1, [[0, 1]]]

      iex> Day9.moveHead("U", [0,1, [[0, 1]]])
      [0,2, [[0, 2], [0, 1]]]

      iex> Day9.moveHead("D", [0,0, []])
      [0,-1, [[0, -1]]]

      iex> Day9.moveHead("D", [0,-1, [[0, -1]]])
      [0,-2, [[0, -2], [0, -1]]]

  """

  def moveHead("R", [x,y, []]), do: [x+1,y, [[x+1,y]]]
  def moveHead("R", [x,y, [head | tail]]), do: [x+1,y, [[x+1,y] , head | tail]]
  def moveHead("L", [x,y, []]), do: [x-1,y, [[x-1,y]]]
  def moveHead("L", [x,y, [head | tail]]), do: [x-1,y, [[x-1,y] , head | tail]]
  def moveHead("U", [x,y, []]), do: [x,y+1, [[x,y+1]]]
  def moveHead("U", [x,y, [head | tail]]), do: [x,y+1, [[x,y+1], head | tail]]
  def moveHead("D", [x,y, []]), do: [x,y-1, [[x,y-1]]]
  def moveHead("D", [x,y, [head | tail]]), do: [x,y-1, [[x,y-1], head | tail]]

  @doc """
  move a tail

  ## Examples

      Same coordinate, nothing in moves
      iex> Day9.moveTail([0,0], [0,0, [[0,0]]])
      [0,0, [[0,0]]]

      Same coordinate, nothing in moves
      iex> Day9.moveTail([-4,3], [-4,3, [[0,0]]])
      [-4,3, [[0,0]]]

      Same coordinate, with move inside
      iex> Day9.moveTail([-7,-6], [-7,-6, [[0,1]]])
      [-7,-6, [[0,1]]]

      Same coordinate, with moves inside
      iex> Day9.moveTail([-7,-6], [-7,-6, [[0,1], [5,6]]])
      [-7,-6, [[0,1], [5,6]]]

      Difference of one in any direction does not move
      iex> Day9.moveTail([-6,-5], [-7,-5, [[0,1], [5,6]]])
      [-7, -5, [[0, 1], [5, 6]]]

      Difference diagonal of one will not move

      Difference or two in primary directions goes one
      iex> Day9.moveTail([2,0], [0,0,[[0,0]]])
      [1,0, [[1,0], [0,0]]]

      iex> Day9.moveTail([2,0], [0,0,[[7,-9]]])
      [1,0, [[1,0], [7, -9]]]


  """

  #distance of zero
  def moveTail([x,y], [x, y, [head | _tail = []]]), do: [x, y, [head]]
  def moveTail([x,y], [x, y, [head | tail]]), do: [x, y, [head | tail]]
  #distance of one
  def moveTail([x1,y], [x2, y, [head | _tail = []]]) when x1 == x2 + 1, do: [x2, y, [head]]
  def moveTail([x1,y], [x2, y, [head | tail]]) when x1 == x2 + 1, do: [x2, y, [head | tail]]
  def moveTail([x1,y], [x2, y, [head | _tail = []]]) when x1 == x2 - 1, do: [x2, y, [head]]
  def moveTail([x1,y], [x2, y, [head | tail]]) when x1 == x2 - 1, do: [x2, y, [head | tail]]

  def moveTail([x,y1], [x, y2, [[head | _tail = []]]]) when y1 == y2 + 1, do: [x, y2, [head]]
  def moveTail([x,y1], [x, y2, [head | tail]]) when y1 == y2 + 1, do: [x, y2, [head | tail]]
  def moveTail([x,y1], [x, y2, [head | _tail = []]]) when y1 == y2 - 1, do: [x, y2, [head]]
  def moveTail([x,y1], [x, y2, [head | tail]]) when y1 == y2 - 1, do: [x, y2, [head | tail]]

  def moveTail([x1,y1], [x2, y2, [head | _tail = []]]) when x1 == x2 + 1 and y1 == y2 + 1, do: [x2, y2, [head]]
  def moveTail([x1,y1], [x2, y2, [head | tail]]) when x1 == x2 + 1 and y1 == y2 + 1, do: [x2, y2, [head | tail]]
  def moveTail([x1,y1], [x2, y2, [head | _tail = []]]) when x1 == x2 + 1 and y1 == y2 - 1, do: [x2, y2, [head]]
  def moveTail([x1,y1], [x2, y2, [head | tail]]) when x1 == x2 + 1 and y1 == y2 - 1, do: [x2, y2, [head | tail]]
  def moveTail([x1,y1], [x2, y2, [head | _tail = []]]) when x1 == x2 - 1 and y1 == y2 - 1, do: [x2, y2, [head]]
  def moveTail([x1,y1], [x2, y2, [head | tail]]) when x1 == x2 - 1 and y1 == y2 - 1, do: [x2, y2, [head | tail]]
  def moveTail([x1,y1], [x2, y2, [head | _tail = []]]) when x1 == x2 - 1 and y1 == y2 + 1, do: [x2, y2, [head]]
  def moveTail([x1,y1], [x2, y2, [head | tail]]) when x1 == x2 - 1 and y1 == y2 + 1, do: [x2, y2, [head | tail]]

  #distance of two
  def moveTail([x1,y], [x2, y, [head | _tail = []]]) when x1 == x2 + 2, do: [x2+1, y, [[x2+1,y], head]]
  def moveTail([x1,y], [x2, y, [head | tail]]) when x1 == x2 + 2, do: [x2+1, y, [[x2+1,y], head | tail]]
  def moveTail([x,y1], [x, y2, [head | _tail = []]]) when y1 == y2 + 2, do: [x, y2 + 1, [[x,y2 + 1], head]]
  def moveTail([x,y1], [x, y2, [head | tail]]) when y1 == y2 + 2, do: [x, y2 + 1, [[x,y2 + 1], head | tail]]
  def moveTail([x,y1], [x, y2, [head | _tail = []]]) when y1 == y2 - 2, do: [x, y2 - 1, [[x,y2 - 1], head]]
  def moveTail([x,y1], [x, y2, [head | tail]]) when y1 == y2 - 2, do: [x, y2 - 1, [[x,y2 - 1], head | tail]]
  def moveTail([x1,y], [x2, y, [head | _tail = []]]) when x1 == x2 - 2, do: [x2-1, y, [[x2-1,y], head]]
  def moveTail([x1,y], [x2, y, [head | tail]]) when x1 == x2 - 2, do: [x2-1, y, [[x2-1,y], head | tail]]

  #diagnonals (should be at least four sets -- so 8)
   #1 and #2
  def moveTail([x1,y1], [x2, y2, [head | _tail = []]]) when x1 == x2 - 2 and y1 == y2 + 1 or x1 == x2 - 1 and y1 == y2 + 2 or x1 == x2 - 2 and y1 == y2 + 2, do: [x2-1,y2+1, [[x2-1,y2+1], head]]
  def moveTail([x1,y1], [x2, y2, [head | tail]])       when x1 == x2 - 2 and y1 == y2 + 1 or x1 == x2 - 1 and y1 == y2 + 2 or x1 == x2 - 2 and y1 == y2 + 2, do: [x2-1,y2+1, [[x2-1,y2+1], head | tail]]
  #3 and #4
  def moveTail([x1,y1], [x2, y2, [head | _tail = []]]) when x1 == x2 + 1 and y1 == y2 + 2 or x1 == x2 + 2 and y1 == y2 + 1 or x1 == x2 + 2 and y1 == y2 + 2, do: [x2+1,y2+1, [[x2+1,y2+1], head]]
  def moveTail([x1,y1], [x2, y2, [head | tail]])       when x1 == x2 + 1 and y1 == y2 + 2 or x1 == x2 + 2 and y1 == y2 + 1 or x1 == x2 + 2 and y1 == y2 + 2, do: [x2+1,y2+1, [[x2+1,y2+1], head | tail]]
  #5 and #6
  def moveTail([x1,y1], [x2, y2, [head | _tail = []]]) when x1 == x2 + 2 and y1 == y2 - 1 or x1 == x2 + 1 and y1 == y2 - 2  or x1 == x2 + 2 and y1 == y2 - 2, do: [x2+1,y2-1, [[x2+1,y2-1], head]]
  def moveTail([x1,y1], [x2, y2, [head | tail]])       when x1 == x2 + 2 and y1 == y2 - 1 or x1 == x2 + 1 and y1 == y2 - 2 or x1 == x2 + 2 and y1 == y2 - 2, do: [x2+1,y2-1, [[x2+1,y2-1], head | tail]]
  #7 and #8
  def moveTail([x1,y1], [x2, y2, [head | _tail = []]]) when x1 == x2 - 1 and y1 == y2 - 2 or x1 == x2 - 2 and y1 == y2 - 1  or x1 == x2 - 2 and y1 == y2 - 2, do: [x2-1,y2-1, [[x2-1,y2-1], head]]
  def moveTail([x1,y1], [x2, y2, [head | tail]])       when x1 == x2 - 1 and y1 == y2 - 2 or x1 == x2 - 2 and y1 == y2 - 1 or x1 == x2 - 2 and y1 == y2 - 2, do: [x2-1,y2-1, [[x2-1,y2-1], head | tail]]

    #repeat the proper number of times
    #for position 9's only count unique --> reduce to map with keys of x,y and count.
    #then sum it.

    #call a catch up move with leader and one --> place result into position map
    #then one and two --> place two into position map
    #....
    #then eight and nine --> place nine into postion map
    #update nine's visited --> should only place coordinates
  #end


  def repeatMoveTail(moves, 9), do: moves
  def repeatMoveTail(moves, count) do
    moves |> Enum.reduce([0,0, [[0,0]]], fn (position, positions) -> moveTail(position, positions) end)
          |> Enum.reverse()
          |> hd()
          |> Enum.reverse()
          |> repeatMoveTail(count + 1)
  end

  @doc """
  Part 2 moves 9 tails

  ## Example

      iex> Day9.part2(["R 5","U 8","L 8","D 3","R 17","D 10","L 25","U 20"])
      36

  """

  def part2(contents) do
    contents |> Enum.map(fn move -> unwrapMoves(move) end)
                                 |> Enum.flat_map(fn move -> move end)
                                 |> Enum.reduce([0,0, [[0,0]]], fn (move, positions) -> moveHead(move, positions) end)
                                 |> Enum.reverse() # get positions to top
                                 |> hd() # grab positions
                                 |> Enum.reverse() # flip to correct order
                                 |> repeatMoveTail(0) # calculate all tails
                                 |> Enum.sort() # get like coordinates together
                                 |> Enum.chunk_by(fn x -> x end) # duplicates get collected
                                 |> length() # length of unique
  end

  def solve2 do
    {:ok, contents} = File.read("day9.txt")
    part2(String.split(contents,"\n"))
  end
end
