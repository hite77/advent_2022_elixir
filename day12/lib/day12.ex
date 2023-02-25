defmodule Day12 do
  @moduledoc """
  Documentation for `Day12`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Day12.hello()
      :world

  """
  def hello do
    :world
  end

  def find(_maps, _character, [yextents, _xextents], [yextents,_x]), do: nil
  def find(maps, character, [yextents, xextents], [y,xextents]), do: find(maps, character, [yextents, xextents], [y+1,0])
  def find(maps, character, [yextents, xextents], [y,x]) do
    if maps[y][x] == character do
      [y,x]
    else
      find(maps, character, [yextents, xextents], [y,x+1])
    end
  end

  def findMoreAyes(map, [head | tail]) do
    [y,x] = head
    result = find(map, "a", calculateExtents(map), [y,x+1])
    case result do
      nil -> [head | tail]
      [y,x] -> findMoreAyes(map, [[y,x], head | tail])
    end
  end
  def findAllAyes(map) do
    start = find(map, "S", calculateExtents(map), [0,0])
    result = find(map, "a", calculateExtents(map), [0,0])
    findMoreAyes(map, [result, start])
  end

  def calculateExtents(map) do
    y = length(Map.keys(map))
    x = length(Map.keys(map[0]))
    [y, x]
  end

  def parse(contents) do
    maps = String.split(contents, "\n", trim: true)  |> Enum.map(fn line -> String.graphemes(line) end)
                                                     |> Enum.map(fn line->  Stream.with_index(line, 0) |> Enum.reduce(%{}, fn({v,k}, acc)-> Map.put(acc, k, v) end) end)
                                                     |> Stream.with_index(0) |> Enum.reduce(%{}, fn({v,k}, acc)-> Map.put(acc, k, v) end)
    extents = calculateExtents(maps)
    positionStart = find(maps,"S", extents, [0,0])
    [positionStart, maps]
  end

  def move(_map, _from, [-1, _tox], _extents), do: false
  def move(_map, _from, [_toy, -1], _extents), do: false
  def move(_map, _from, [_toy,  x], [_extenty, x]), do: false
  def move(_map, _from, [y,  _tox], [y, _extentx]), do: false
  def move(map, [fromy, fromx], [toy, tox], _extents) do
    <<from::utf8>> = map[fromy][fromx] # might be S
    <<to::utf8>> = map[toy][tox]

    cond do
      (to == ?E and ((?z - from) < 2)) -> :solved
      to == ?E                         -> (?z - from) < 2
      from == ?S                       -> (to - ?a) < 2
      true                             -> (to - from) < 2
    end
  end

  def tryDirection([y,x], [y2,x2], extents, map, from, to, moves, visited, solved) do
    canMove = move(map, [y, x], [y2, x2], extents)
    cond do
      solved             -> [true, to, moves, visited]
      [y2,x2] in visited -> [false, to, moves, visited]
       canMove == true    -> addMove([y2, x2], to, from, moves, visited)
       canMove == :solved -> [_solved, to, moves, visited] = addMove([y2, x2], to, from, moves, visited)
                             [true, to-1, moves, visited]
       true               -> [false, to, moves, visited]
    end
  end

  def calculateMoves(true, _map, _key, moves, visited), do: [true, moves, visited]
  def calculateMoves(false, map, key, moves, visited) do
    yextents = length(Map.keys(map))
    xextents = length(Map.keys(map[0]))
    extents = [yextents, xextents]
    move = moves[key]
    [y, x] = move |> hd()
    to = (Map.keys(moves) |> Enum.sort() |> Enum.reverse() |> hd()) + 1

    #up
    [solved, to, moves, visited] = tryDirection([y, x], [y-1,x], extents, map, key, to, moves, visited, false)
    #right
    [solved, to, moves, visited] = tryDirection([y, x], [y, x + 1], extents, map, key, to, moves, visited, solved)
    #down
    [solved, to, moves, visited] = tryDirection([y, x], [y+1, x], extents, map, key, to, moves, visited, solved)
    #left
    [solved, to, moves, visited] = tryDirection([y, x], [y, x - 1], extents, map, key, to, moves, visited, solved)

    moves = Map.delete(moves, key)
    case solved do
      true -> [true, moves[to], visited]
      false -> [false, moves, visited]
    end
  end

  def addMove(move, to, from, moves, [head|tail]) do
    [head2| tail2] = moves[from]
    moves = put_in(moves[to], [move, head2 | tail2])
    [false, to + 1, moves, [move, head | tail]]
  end

  def loopKeys(true, _map, _keys, moves, visited), do: [true, moves, visited]
  def loopKeys(false, _map, [], moves, visited), do: [false, moves, visited]
  def loopKeys(false, map, [head | tail], moves, visited) do
    [solved, moves, visited] = calculateMoves(false, map, head, moves, visited)
    loopKeys(solved, map, tail, moves, visited)
  end

  def calculateMoves(true, _map, moves, _visited), do: moves
  def calculateMoves(false, map, moves, visited) do
    keys = Map.keys(moves)
    cond do
      keys == [] -> :large
      true       -> [solved, moves, visited] = loopKeys(false, map, Map.keys(moves), moves, visited)
                    calculateMoves(solved, map, moves, visited)
    end

  end

  def part1(contents) do
    [start, map] = parse(contents)
    (calculateMoves(false, map, %{0 => [start]}, [start]) |> Enum.count()) - 1
  end

  def handleNoRoutesAndIndicateProgress(starts,start, solved, map, moves, visited) do
    IO.puts("Pos: #{Enum.find_index(starts, & &1 == start)} of #{length(starts)}")
    result = calculateMoves(solved, map, moves, visited)
    cond do
      result == :large -> 1000 #462 from start should beat this
      true             -> (result |> Enum.count()) - 1
    end
  end

  def part2(contents) do
    [_start, map] = parse(contents)
    starts = findAllAyes(map)
    starts           |> Enum.map(fn (start) -> handleNoRoutesAndIndicateProgress(starts, start, false, map, %{0 => [start]}, [start]) end)
                     |> Enum.sort()
                     |> hd()
  end

  def solve1 do
    {:ok, contents} = File.read("Day12.txt")
    part1(contents)
  end

  def solve2 do
    {:ok, contents} = File.read("Day12.txt")
    part2(contents)
  end
end
