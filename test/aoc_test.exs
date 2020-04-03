defmodule AocTest do
  use ExUnit.Case

  test "day 2 test case" do
    output =
      "1,1,1,4,99,5,6,0,99"
      |> String.split(",")
      |> Enum.map(&String.to_integer/1)
      |> IntCode.run
    assert output == "30,1,1,4,2,5,6,0,99"
  end

end