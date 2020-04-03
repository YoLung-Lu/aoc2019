defmodule UtilTest do
  use ExUnit.Case


  #  test "sequence number generator" do
  #     t = MathUtil.generateSequenceNumber(5, 9..5)
  #     |> IO.inspect
  #     IO.inspect(length(t))
  #     |> IO.inspect(&(length/1))
  #    # assert true
  #     test = TestUtil.combinations(3, [5, 4, 3, 2, 1, 0])
  #     |> IO.inspect
  #     IO.inspect(length(test))
  #  end

  #  test "math" do
  #     IO.inspect(MathUtil.separateHead(nil))
  #     IO.inspect(MathUtil.separateHead("123503"))
  #     IO.inspect(MathUtil.separateHead("207007"))
  #     IO.inspect(MathUtil.separateHead("207007"))
  #     IO.inspect(MathUtil.separateHead(nil))
  #  # TODO: not working.
  #     a = String.match?("123", ~r/(?i)(?:([0-9])\\1{2,})*/)
  #    assert true
  #  end

   test "recursive" do
     list = MyList2.delete_all(["Apple", "Pear", "Grapefruit", "Pear"], "Pear")
     assert list == ["Apple", "Grapefruit"]
   end

  test "list to map" do
    map1 = StructureUtil.list_to_indexed_map([:a, :b, :c], 0)
    assert map1 == %{0 => :a, 1 => :b, 2 => :c}

    map2 = StructureUtil.list_to_indexed_map([:a, :b, :c], 1)
    assert map2 == %{1 => :a, 2 => :b, 3 => :c}
  end

  test "map to list" do
    list_input = [:a, :b, :c]
    map1 = StructureUtil.list_to_indexed_map(list_input, 0)
    list = StructureUtil.indexed_map_to_list(map1, 0)
    assert list == list_input
  end

  test "Operation" do
    op1 = Operation.new(1, 2, 3)
    op2 = Operation.new(1, 2, 3, -1)
    assert op1 == op2
  end

  test "The state" do
    state = StateExecution.new()
    assert StateExecution.is_halt(state) == false

    state = StateExecution.halt()
    assert StateExecution.is_halt(state) == true
  end
end