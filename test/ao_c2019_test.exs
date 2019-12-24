defmodule AOC2019Test do
  use ExUnit.Case
  # doctest AOC2019

  test "day 3 - 2" do
    assert App.day32("input/day3test.txt") == 610
    assert App.day32("input/day3test2.txt") == 410
  end

  test "day 3 - 2 distance" do
    line1List = [991, 557, 554, 998, -861, -301, -891, 180]
    distance = LineWalker.findPointDistanceOnLine(line1List, [0, 1254])
    distance2 = LineWalker.findPointDistanceOnLine(line1List, [-207, 1260])
    assert distance  == 4946
    assert distance2 == 5159

    line2List = [100, -100, 50, 50]
    distance3 = LineWalker.findPointDistanceOnLine(line1List, [1000, 1000])
    distance2 = LineWalker.findPointDistanceOnLine(line1List, [20, 0])
    assert distance3  == nil
    assert distance2 == 20
  end

  test "recursive" do
    list = MyList2.delete_all(["Apple", "Pear", "Grapefruit", "Pear"], "Pear")
    assert list == ["Apple", "Grapefruit"]
  end
end
