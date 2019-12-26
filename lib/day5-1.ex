
defmodule DiagnosticProgram do
  def run(list) do
    index = 0
    op = analyzeOperation(list, index)
    executeCommand(list, index, op)
  end

  defp executeCommand(list, index, {opCode, a, b, c}) when opCode == 1 do
    index = index + 1
    {param1, index} = getParam(list, index, a)
    {param2, index} = getParam(list, index, b)
    
    sum = param1 + param2
    target = Enum.at(list, index)
    list = List.replace_at(list, target, sum)
    index = index + 1
    executeCommand(list, index, analyzeOperation(list, index))
  end

  defp executeCommand(list, index, {opCode, a, b, c}) when opCode == 2 do
    index = index + 1
    {param1, index} = getParam(list, index, a)
    {param2, index} = getParam(list, index, b)
    
    multiply = param1 * param2
    target = Enum.at(list, index)
    list = List.replace_at(list, target, multiply)
    index = index + 1
    executeCommand(list, index, analyzeOperation(list, index))
  end

  defp executeCommand(list, index, {opCode, a, b, c}) when opCode == 3 do
    index = index + 1
    target = Enum.at(list, index)
    list = List.replace_at(list, target, a)
    index = index + 1
    executeCommand(list, index, analyzeOperation(list, index))
  end

  defp executeCommand(list, index, {opCode, a, b, c}) when opCode == 4 do
    index = index + 1
    {param1, index} = getParam(list, index, a)
    IO.inspect(param1)
    executeCommand(list, index, analyzeOperation(list, index))
  end

  defp executeCommand(list, index, {opCode, a, b, c}) when opCode == 99 do
    list
  end
  
  def analyzeOperation(list, index) do 
    op = Enum.at(list, index)
    opCode = rem(op, 100)
    c = div(op, 10000)
    b = div((op - c * 10000), 1000)
    a = cond do
      op == 3 -> getFromIO()
      true -> div((op - c * 10000 - b * 1000), 100)
    end
    IO.inspect({opCode, a, b, c})
  end

  def getFromIO() do
    1
  end

  defp listIndexPositionMode(list, index) do
      valueIndex = Enum.at(list, index)
      Enum.at(list, valueIndex)
  end 

  def getParam(list, index, mode) when mode == 0 do
    param = listIndexPositionMode(list, index)
    {param, index + 1}
  end

  def getParam(list, index, mode) when mode == 1 do
    param = valueIndex = Enum.at(list, index)
    {param, index + 1}
  end
end