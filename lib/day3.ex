defmodule CrossedWires do
  def createMap(inputList) do
    # There are 3 elements in the input: [[line1], [line2], []]
    line1 = hd(inputList)
    line2 = hd(tl(inputList))
    # MyLog.log(line2)
  end
end