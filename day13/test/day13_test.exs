defmodule Day13Test do
  use ExUnit.Case
  doctest Day13

  test "greets the world" do
    assert Day13.hello() == :world
  end

  test "parse packet" do
    assert Day13.parsePacket("[1,[2,[3,[4,[5,6,7]]]],8,9]") == [1,[2,[3,[4,[5,6,7]]]],8,9]
  end

  test "spike" do
    [head | tail] = [[[]]]
    assert head == [[]]
    # tail is outer one
    assert tail == []

    [head | tail] = [[]]
    assert head == []
    assert tail == []

    [head | tail] = [1,[2,[3,[4,[5,6,7]]]],8,9]
    # check if one element head
    assert head == 1
    [head | tail] = tail
    # this head has way more than one in tail
    assert head == [2, [3, [4, [5, 6, 7]]]]
    assert tail == [8,9]
    # assertions of tail will need head 2, and tail 2 off tail
    [head3 | tail3] = tail
    assert head3 == 8
    assert tail3 == 9
    [head2 | tail2] = head
    assert head2 ==  2
    assert tail2 == [[3, [4, [5, 6, 7]]]]
    #assert
  end
end
