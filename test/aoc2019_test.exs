defmodule AOC2019Test do
  use ExUnit.Case
  # doctest AOC2019

  test "math" do
  #   IO.inspect(MathUtil.separateHead(nil))
  #   IO.inspect(MathUtil.separateHead("123503"))
    # IO.inspect(MathUtil.separateHead("207007"))
    # IO.inspect(MathUtil.separateHead("207007"))
    # IO.inspect(MathUtil.separateHead(nil))
  # TODO: not working.
    # a = String.match?("123", ~r/(?i)(?:([0-9])\\1{2,})*/)
    assert true
  end

  test "day 5 - 1" do
    # assert {1, 0, 1, 0} = DiagnosticProgram.analyzeOperation([1001, 0], 0)
    # assert {1, 0, 1, 1} = DiagnosticProgram.analyzeOperation([11001, 0], 0)
    # assert {2, 0, 0, 0} = DiagnosticProgram.analyzeOperation([2, 0], 0)
    # assert {3, 1, 0, 0} = DiagnosticProgram.analyzeOperation([3, 0], 0)
    # assert {50, 2} = DiagnosticProgram.getParam([1, 2, 50], 1, 0)
    # assert {2, 2} = DiagnosticProgram.getParam([1, 2, 50], 1, 1)
    # App.day51("input/day5test.txt", "output/day5-1test.txt")
    App.day51()
  end

  # test "day 4 - 2" do
  #   String.codepoints("112334")
  #   IO.inspect(a)
  #   assert false == SecureContainer.contentStraitChar(["1", "1", "2", "3", "3", "3"], 4)
  #   assert true == SecureContainer.contentStraitChar(["1", "1", "2", "3", "3", "3"], 2)
  #   assert true == SecureContainer.contentStraitChar(["1", "2", "3", "3", "3", "3"], 4)
  #   assert false == SecureContainer.contentStraitChar(["1", "2", "3", "3", "3", "3"], 3)
  # end 

  # test "day 4 - 1" do
  #   assert SecureContainer.checkCode("23456") == false
  #   assert SecureContainer.checkCode("123456") == false
  #   assert SecureContainer.checkCode("123316") == false
  #   assert SecureContainer.checkCode("123356") == true
  #   assert SecureContainer.checkCode("277889") == true
  #   assert SecureContainer.checkCode("677881") == false
  # end

  # test "day 3 - 2" do
  #   assert App.day32("input/day3test.txt") == 610
  #   assert App.day32("input/day3test2.txt") == 410
  # end

  # test "day 3 - 2 distance" do
  #   line1List = [991, 557, 554, 998, -861, -301, -891, 180]
  #   distance = LineWalker.findPointDistanceOnLine(line1List, [0, 1254])
  #   distance2 = LineWalker.findPointDistanceOnLine(line1List, [-207, 1260])
  #   assert distance  == 4946
  #   assert distance2 == 5159

  #   line2List = [100, -100, 50, 50]
  #   distance3 = LineWalker.findPointDistanceOnLine(line1List, [1000, 1000])
  #   distance2 = LineWalker.findPointDistanceOnLine(line1List, [20, 0])
  #   assert distance3  == nil
  #   assert distance2 == 20
  # end

  # test "recursive" do
  #   list = MyList2.delete_all(["Apple", "Pear", "Grapefruit", "Pear"], "Pear")
  #   assert list == ["Apple", "Grapefruit"]
  # end
end
