defmodule DiagnosticProgram7 do
  def runSequentially(list, input) do
    MathUtil.generateSequenceNumber(5, 4..0)
    |> Enum.map(fn x -> 
      runEach(list, x, 0)
    end)
    |> Enum.max
  end

  def runEach(list, [hd | tl], output) do
    value = [hd] ++ [output]
    runEach(list, tl, run(list, value))
  end

  def runEach(list, [], output) do
    output
  end

  def run(list, input) do
#     IO.inspect("RUN:: ")
#     IO.inspect(input)
    index = 0
    op = analyzeOperation(list, index)
    commandStateMachine(list, index, op, input, :continue, 0)
  end

  def commandStateMachine(list, index, op, input, code, output) when code == :continue do
    {list, index, op, code, out} = executeCommand(list, index, op)
    output = cond do
      code == :op4 -> out
      true -> output
    end
    commandStateMachine(list, index, op, input, code, output)
  end

  def commandStateMachine(list, index, op, input, code, output) when code == :op4 do
    {list, index, op, code, out} = executeCommand(list, index, analyzeOperation(list, index))
    commandStateMachine(list, index, op, input, code, output)
  end

  def commandStateMachine(list, index, op, input, code, output) when code == :op3 do
    {inputNumber, input} = 
    cond do
      length(input) == 1 -> {hd(input), input}
      true -> 
      [number | rest] = input
      {number, rest}
    end

#    IO.inspect("Execute op3, with input: " <> Integer.to_string(inputNumber))
    {list, index, op, code, out} = executeCommand(list, index, op, inputNumber)
    output = cond do
      code == :op4 -> out
      true -> output
    end
    commandStateMachine(list, index, op, input, code, output)
  end
  
  def commandStateMachine(_, _, _, _, code, output) when code == :stop do
    output
  end

  defp executeCommand(list, index, {opCode, a, b, _}) when opCode == 1 do
    index = index + 1
    {param1, index} = getParam(list, index, a)
    {param2, index} = getParam(list, index, b)
    
    sum = param1 + param2
    target = Enum.at(list, index)
    list = List.replace_at(list, target, sum)
    index = index + 1
    executeCommand(list, index, analyzeOperation(list, index))
  end

  defp executeCommand(list, index, {opCode, a, b, _}) when opCode == 2 do
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
    {list, index, {opCode, a, b, c}, :op3, 0}
  end

  # Special recursion function that takes more param.
  defp executeCommand(list, index, {opCode, _, _, _}, input) when opCode == 3 do
    index = index + 1
    target = Enum.at(list, index)
    list = List.replace_at(list, target, input)
    index = index + 1
    executeCommand(list, index, analyzeOperation(list, index))
  end

  defp executeCommand(list, index, {opCode, a, b, c}) when opCode == 4 do
    index = index + 1
    {param1, index} = getParam(list, index, a)

    # return the output to previous level.
    IO.inspect("OUTPUT: " <> Integer.to_string(param1))
    {list, index, {opCode, a, b, c}, :op4, param1}
    # executeCommand(list, index, analyzeOperation(list, index))
  end

  defp executeCommand(list, index, {opCode, a, b, _}) when opCode == 5 do
    index = index + 1
    {param1, index} = getParam(list, index, a)
    {param2, index} = getParam(list, index, b)
    index = cond do
      param1 != 0 -> 
        # IO.inspect("Jump to: " <> Integer.to_string(param2))
        param2
      true -> index
    end
    executeCommand(list, index, analyzeOperation(list, index))
  end

  defp executeCommand(list, index, {opCode, a, b, _}) when opCode == 6 do
    index = index + 1
    {param1, index} = getParam(list, index, a)
    {param2, index} = getParam(list, index, b)
    index = cond do
      param1 == 0 -> 
        # IO.inspect("Jump to: " <> Integer.to_string(param2))
        param2
      true -> index
    end
    executeCommand(list, index, analyzeOperation(list, index))
  end

  defp executeCommand(list, index, {opCode, a, b, _}) when opCode == 7 do
    index = index + 1
    {param1, index} = getParam(list, index, a)
    {param2, index} = getParam(list, index, b)
    {param3, index} = getParam(list, index, 1)

    storeValue = 
      cond do
        param1 < param2 -> 1
        true -> 0
      end
    list = List.replace_at(list, param3, storeValue)
    executeCommand(list, index, analyzeOperation(list, index))
  end

  defp executeCommand(list, index, {opCode, a, b, _}) when opCode == 8 do
    index = index + 1
    {param1, index} = getParam(list, index, a)
    {param2, index} = getParam(list, index, b)
    {param3, index} = getParam(list, index, 1)

    storeValue = 
      cond do
        param1 == param2 -> 1
        true -> 0
      end
      # IO.inspect("8 replace: " <> Integer.to_string(param3))
    list = List.replace_at(list, param3, storeValue)
    executeCommand(list, index, analyzeOperation(list, index))
  end

  defp executeCommand(list, index, {opCode, _, _, _}) when opCode == 99 do
    {list, index, opCode, :stop, 0}
  end
  
  def analyzeOperation(list, index) do 
    op = Enum.at(list, index)
    opCode = rem(op, 100)
    c = div(op, 10000)
    b = div((op - c * 10000), 1000)
    a = div((op - c * 10000 - b * 1000), 100)
#    IO.inspect({opCode, a, b, c})
    {opCode, a, b, c}
  end

  defp listIndexPositionMode(list, index) do
      valueIndex = Enum.at(list, index)
      Enum.at(list, valueIndex)
  end 

  # parameter mode.
  def getParam(list, index, mode) when mode == 0 do
    param = listIndexPositionMode(list, index)
    {param, index + 1}
  end

  # immediate mode.
  def getParam(list, index, mode) when mode == 1 do
    param = Enum.at(list, index)
    {param, index + 1}
  end
end