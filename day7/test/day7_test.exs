defmodule Day7Test do
  use ExUnit.Case
  doctest Day7

  test "ls keeps path and modal same" do
    assert Day7.parsing("$ ls", [["a", "e"], %{"/a" => [{"/a/e"}]}]) == [["a", "e"], %{"/a" => [{"/a/e"}]}]
  end

  test "cd dir will work in several modes" do
    assert Day7.parsing("$ cd e", [[], %{"/a" => [{"/a/e"}]}]) == [["e"], %{"/a" => [{"/a/e"}]}]
    assert Day7.parsing("$ cd e", [["a"], %{"/a" => [{"/a/e"}]}]) == [["a", "e"], %{"/a" => [{"/a/e"}]}]
    assert Day7.parsing("$ cd e", [["a", "b"], %{"/a" => [{"/a/e"}]}]) == [["a", "b", "e"], %{"/a" => [{"/a/e"}]}]
    assert Day7.parsing("$ cd e", [["a", "b", "c"], %{"/a" => [{"/a/e"}]}]) == [["a", "b", "c", "e"], %{"/a" => [{"/a/e"}]}]
  end

  test "cd / willl work in several modes" do
    assert Day7.parsing("$ cd /", [["a", "e"], %{"/a" => [{"/a/e"}]}]) == [[], %{"/a" => [{"/a/e"}]}]
  end

  test "cd .. will work in several modes" do
    assert Day7.parsing("$ cd ..", [["a"], %{}]) == [[], %{}]
    assert Day7.parsing("$ cd ..", [["a", "e"], %{"/a" => [{"/a/e"}]}]) == [["a"], %{"/a" => [{"/a/e"}]}]
    assert Day7.parsing("$ cd ..", [["a", "e", "f"], %{"/a" => [{"/a/e"}]}]) == [["a", "e"], %{"/a" => [{"/a/e"}]}]
    assert Day7.parsing("$ cd ..", [["a", "b", "c", "d"], %{"/a" => [{"/a/e"}]}]) == [["a", "b", "c"], %{"/a" => [{"/a/e"}]}]
    assert Day7.parsing("$ cd ..", [["a", "b", "c", "d", "e"], %{"/a" => [{"/a/e"}]}]) == [["a", "b", "c", "d"], %{"/a" => [{"/a/e"}]}]
  end

  test "add item conditions" do
    assert Day7.parsing("29116 f", [[], %{}]) == [[], %{"/" => [{29116, "f"}]}]
    assert Day7.parsing("16116 z.txt", [["a"], %{}]) == [["a"], %{"/a" => [{16116, "z.txt"}]}]
    assert Day7.parsing("42 rest.def", [["a", "b"], %{}]) == [["a", "b"], %{"/a/b" => [{42, "rest.def"}]}]
    assert Day7.parsing("456 shrek.movie.really", [["a", "b", "c"], %{}]) == [["a", "b", "c"], %{"/a/b/c" => [{456, "shrek.movie.really"}]}]
  end

  test "add dir conditions" do
    assert Day7.parsing("dir f", [[], %{}]) == [[], %{"/" => [{"/f"}]}]
    assert Day7.parsing("dir zztop", [["a"], %{}]) == [["a"], %{"/a" => [{"/a/zztop"}]}]
    assert Day7.parsing("dir something", [["a", "b"], %{}]) == [["a", "b"], %{"/a/b" => [{"/a/b/something"}]}]
    assert Day7.parsing("dir works", [["a", "b", "c"], %{}]) == [["a", "b", "c"], %{"/a/b/c" => [{"/a/b/c/works"}]}]
  end

  test "parsing" do
    input = "$ cd /\n$ ls\ndir a\n14848514 b.txt\n8504156 c.dat\ndir d\n$ cd a\n$ ls\ndir e\n29116 f\n2557 g\n62596 h.lst\n$ cd e\n$ ls\n584 i\n$ cd ..\n$ cd ..\n$ cd d\n$ ls\n4060174 j\n8033020 d.log\n5626152 d.ext\n7214296 k\n"
    assert input |> String.split("\n")
                 |> Enum.reduce([[], %{}], fn (item, files) -> Day7.parsing(item, files) end) ==
                  [["d"], %{"/" => [{"/a"}, {14848514, "b.txt"}, {8504156, "c.dat"}, {"/d"}],
                  "/a" => [{"/a/e"}, {29116, "f"}, {2557, "g"}, {62596, "h.lst"}],
                  "/a/e" => [{584, "i"}],
                  "/d" => [{4060174, "j"}, {8033020, "d.log"}, {5626152, "d.ext"}, {7214296, "k"}]}]
  end

  test "part 1" do
    input = "$ cd /\n$ ls\ndir a\n14848514 b.txt\n8504156 c.dat\ndir d\n$ cd a\n$ ls\ndir e\n29116 f\n2557 g\n62596 h.lst\n$ cd e\n$ ls\n584 i\n$ cd ..\n$ cd ..\n$ cd d\n$ ls\n4060174 j\n8033020 d.log\n5626152 d.ext\n7214296 k\n"
    assert Day7.part1(input) == 95437
  end

  test "unused space" do
    assert Day7.unusedSpace([584, 94853, 24933642, 48381165]) == 21618835
  end

  test "find folder size to delete" do
    assert Day7.smallestFolder(584, 0, 8381165) == 0
    assert Day7.smallestFolder(94853, 0, 8381165) == 0
    assert Day7.smallestFolder(24933642, 0, 8381165) == 24933642
    assert Day7.smallestFolder(48381165, 24933642, 8381165) == 24933642
  end

  test "part 2" do
    input = "$ cd /\n$ ls\ndir a\n14848514 b.txt\n8504156 c.dat\ndir d\n$ cd a\n$ ls\ndir e\n29116 f\n2557 g\n62596 h.lst\n$ cd e\n$ ls\n584 i\n$ cd ..\n$ cd ..\n$ cd d\n$ ls\n4060174 j\n8033020 d.log\n5626152 d.ext\n7214296 k\n"
    assert Day7.part2(input) == 24933642
  end

  test "adding up sizes of directories up to 100000" do
    assert Day7.sizes({"/a/e", [{584, "i"}]}, %{}) == 584
  end

  test "solve" do
    assert Day7.solve1 == 1642503
    assert Day7.solve2 == 6999588
  end
end
