defmodule Day7 do
  @moduledoc """
  Free up space advent exercise
  """

  @doc """
  Parse out directories and files

  ## Examples
  Ignore ""
  iex> Day7.parsing("", [[], %{"/" => [{"/a"}, {29116, "f"}]}])
  [[], %{"/" => [{"/a"}, {29116, "f"}]}]

  Ignore "$ ls"
  iex> Day7.parsing("$ ls", "anything")
  "anything"

  Set path which is stored at beginning
  iex> Day7.parsing("$ cd /", [["a","e"], %{"/a" => [{"/a/e"}]}])
  [[], %{"/a" => [{"/a/e"}]}]

  Set path to cd ..
  iex> Day7.parsing("$ cd ..", [["a","e"], %{"/a" => [{"/a/e"}]}])
  [["a"], %{"/a" => [{"/a/e"}]}]

  Set path from /
  iex> Day7.parsing("$ cd e", [[], %{"/a" => [{"/a/e"}]}])
  [["e"], %{"/a" => [{"/a/e"}]}]

  Set path to name
  iex> Day7.parsing("$ cd e", [["a"], %{"/a" => [{"/a/e"}]}])
  [["a", "e"], %{"/a" => [{"/a/e"}]}]

  Set path to name with more dirs
  iex> Day7.parsing("$ cd f", [["a", "e"], %{"/a" => [{"/a/e"}]}])
  [["a", "e", "f"], %{"/a" => [{"/a/e"}]}]

  Add directory to empty map
  iex> Day7.parsing("dir jason", [[], %{}])
  [[], %{"/" => [{"/jason"}]}]

  Add directory to empty map
  iex> Day7.parsing("dir e", [["a"], %{}])
  [["a"], %{"/a" => [{"/a/e"}]}]

  Add directory nested to empty map
  iex> Day7.parsing("dir f", [["a", "b"], %{}])
  [["a", "b"], %{"/a/b" => [{"/a/b/f"}]}]

  Add directory to other entries
  iex> Day7.parsing("dir g", [["a","e"], %{"/a/e" => [{43, "file"}]}])
  [["a", "e"], %{"/a/e" => [{43, "file"}, {"/a/e/g"}]}]

  Add file size to empty map
  iex> Day7.parsing("29116 f", [["a"], %{}])
  [["a"], %{"/a" => [{29116, "f"}]}]

  Add file size nested to empty map
  iex> Day7.parsing("134 t.txt", [["y", "z"], %{}])
  [["y", "z"], %{"/y/z" => [{134, "t.txt"}]}]

  Add file size to other entries
  iex> Day7.parsing("35643 z.txt", [["c","d"], %{"/a/b" => [{24, "another"}], "/c/d" => [{43, "file"}]}])
  [["c", "d"], %{"/a/b" => [{24, "another"}], "/c/d" => [{43, "file"}, {35643, "z.txt"}]}]

  """
  def parsing("", files), do: files
  def parsing("$ ls", files), do: files
  def parsing("$ cd /", [[_head | _tail], map]), do: [[], map]
  def parsing("$ cd /", [[], map]), do: [[], map]
  def parsing("$ cd ..", [[_singleDirectory], map]), do: [[], map]
  def parsing("$ cd ..", [[head | tail], map]), do: [removeLast(head, tail), map]
  def parsing("$ cd " <> directory, [[] , map]), do: [[directory] , map]
  def parsing("$ cd " <> directory, [[head | tail] , map]), do: [append(head, tail, directory) , map]
  def parsing("dir " <> directory, [[] , map]) do
    addDir("/", map, directory, [])
  end
  def parsing("dir " <> directory, [[head | tail] , map]) do
    addDir("/" <> Enum.join([head | tail], "/"), map, directory, [head | tail])
  end
  def parsing(item, [[], map]) do
    addSize("/", map, item, [])
  end
  def parsing(item, [[head | tail] , map]) do
    addSize("/" <> Enum.join([head | tail], "/"), map, item, [head | tail])
  end

  def removeLast(head, tail) do
    [head | tail |> :lists.reverse() |> tl() |> :lists.reverse()]
  end

  def addDirectoryToPath("/", directory), do: "/" <> directory
  def addDirectoryToPath(path, directory), do: path <> "/" <> directory

  def addDir(pathString, map, directory, path) do
    addItem(pathString, map, [{addDirectoryToPath(pathString, directory)}], path)
  end

  def addSize(pathString, map, item, path) do
    [size, filename] = String.split(item, " ")
    sizeTuple = {String.to_integer(size), filename}
    addItem(pathString, map, [sizeTuple], path)
  end

  def addItem(pathString, map, item, path) do
    if is_map_key(map, pathString) do
      [path, put_in(map[pathString], Enum.concat(map[pathString], item))]
    else
      [path, put_in(map[pathString], item)]
    end
  end


  @doc """
  Parse out directories and files

  ## Examples
  Ignore ""
  iex> Day7.append("a", ["b","c"], "d")
  ["a", "b", "c", "d"]

  """
  def append(head, tail, add) do
    ender = tail |> Enum.reverse()
    added = [add | ender] |> Enum.reverse()
    [head | added]
  end

  @doc """
  Add up sizes

  ## Examples

  Single item less than 10000
  iex> Day7.sizes({"/a", [{300, "a file"}]}, %{})
  300

  Two items added together
  iex> Day7.sizes({"/e", [{350, "a file"}, {400, "b file"}]}, %{})
  750

  Nested folder added
  iex> Day7.sizes({"/pathDir", [{"/a"}, {338, "a file"}, {750, "b file"}]}, %{"/a" => [{13, "c file"}]})
  1101

  One item as folder but leads to other folders
  iex> Day7.sizes({"/folderInside", [{"/another"}]}, %{"/another" => [{13, "c file"}, {"/c"}], "/c" => [{39, "d file"}]})
  52

  """


  def sizes({_path, []}, _files), do: 0
  def sizes({_path, [{size, _filename}]}, _files), do: size
  def sizes({path, [{size, _filename} | tail]}, files), do: size + sizes({path, tail}, files)
  def sizes({path, [{directory} | tail]}, files), do: sizes({directory, files[directory]}, files) + sizes({path, tail}, files)

  @doc """
  Round off

  ## Examples

  item less than 100000
  iex> Day7.truncate(99999)
  99999

  item equal to 100000
  iex> Day7.truncate(100000)
  100000

  item greater than 100000 will be 0
  iex> Day7.truncate(100001)
  0

  """

  def truncate(size) when size > 100000, do: 0
  def truncate(size), do: size

  def part1(contents) do
    [_path, map] = contents |> String.split("\n")
                            |> Enum.reduce([[], %{}], fn (item, files) -> parsing(item, files) end)

    map |> Enum.map(fn folder -> sizes(folder, map) end)
        |> Enum.map(fn size -> truncate(size) end)
        |> Enum.sum()
  end

  def solve1 do
    {:ok, contents} = File.read("day7.txt")
    part1(contents)
  end
end
