
defmodule IntCode do

  # Public interface for 7-2.
  def run_with_state(map, state) do
    loop_through_operation(map, state)
  end

  def run(inputStr, inputList \\ DiagnosticContainer.set([5])) do
    outputList = inputStr
      |> String.split(",")
      |> Enum.map(&String.to_integer/1)
      |> StructureUtil.list_to_indexed_map(0)
      |> loop_through_operation(OperationExecutionState.new(0, inputList))
      |> OperationExecutionState.get_map
      |> StructureUtil.indexed_map_to_list(0)
      |> Enum.join(",")
#    |> IO.inspect

    output = FileUtil.readFile("output/day7_test.txt")
    output = String.to_integer(output)
    {outputList, output}
  end

  defp loop_through_operation(_, %OperationExecutionState{state: 2} = state) do
#    IO.inspect(map[state.index])
#    IO.inspect("pause")
    state
  end

  defp loop_through_operation(_, %OperationExecutionState{state: 99} = state) do
#    IO.inspect(map[state.index])
#    IO.inspect("stop")
    state
  end

  defp loop_through_operation(map, state) do
    {operation, nextIndex} = map_to_operation(map, state.index)
    {map, nextState} = execute_operation(operation, map, OperationExecutionState.continue(state, nextIndex))
#    IO.inspect({operation, nextState})
    loop_through_operation(map, nextState)
  end

  defp execute_operation(%Operation{opCode: 1} = operation, map, state) do
    sumValue = map[operation.param1] + map[operation.param2]
    map = Map.merge(map, %{operation.param3 => sumValue})
    {map, state}
  end

  defp execute_operation(%Operation{opCode: 2} = operation, map, state) do
    multiplyValue = map[operation.param1] * map[operation.param2]
    map = Map.merge(map, %{operation.param3 => multiplyValue})
    {map, state}
  end

  defp execute_operation(%Operation{opCode: 3} = operation, map, state) do
    # The switch to enable read same diagnostic code or not.
#    {inputValue, diagnostic} = DiagnosticContainer.get(state.get_diagnostic)
    {inputValue, diagnostic} = DiagnosticContainer.get_with_nil(state.get_diagnostic)

    cond do
      inputValue == nil ->
        {map, OperationExecutionState.pause(state, map, state.index - 2)}
      true ->
        map = Map.merge(map, %{operation.param1 => inputValue})
        {map, OperationExecutionState.continue(state, diagnostic)}
    end
  end

  defp execute_operation(%Operation{opCode: 4} = operation, map, state) do
    outputValue = map[operation.param1]
#    MyLog.logToFile(outputValue, "output/day7_test.txt")
    {map, OperationExecutionState.continue_with_output(state, outputValue)}
  end

  # OP5: Jump if true
  defp execute_operation(%Operation{opCode: 5} = operation, map, state) do
    index = cond do
      map[operation.param1] != 0 -> map[operation.param2]
      true -> state.index
    end
    {map, OperationExecutionState.continue(state, index)}
  end

  # OP6: Jump if false
  defp execute_operation(%Operation{opCode: 6} = operation, map, state) do
    index = cond do
      map[operation.param1] == 0 -> map[operation.param2]
      true -> state.index
    end
    {map, OperationExecutionState.continue(state, index)}
  end

  # OP7: Less than
  defp execute_operation(%Operation{opCode: 7} = operation, map, state) do
    value = cond do
      map[operation.param1] < map[operation.param2] -> 1
      true -> 0
    end
    map = Map.merge(map, %{operation.param3 => value})
    {map, state}
  end

  # OP8: Equal
  defp execute_operation(%Operation{opCode: 8} = operation, map, state) do

    value = cond do
      map[operation.param1] == map[operation.param2] -> 1
      true -> 0
    end
    map = Map.merge(map, %{operation.param3 => value})
    {map, state}
  end

  defp execute_operation(%Operation{opCode: 99}, map, state) do
    {map, OperationExecutionState.halt(state, map)}
  end

  defp map_to_operation(map, index) do
    opInt = map[index]
    {opCode, a, b, _} = analyze_opcode(opInt)

#    IO.inspect(index)
#    IO.inspect({opCode, a, b})

    param1Index = get_index_by_mode(map, index + 1, a)
    param2Index = get_index_by_mode(map, index + 2, b)
#    param3Index = get_index_by_mode(map, index + 3, c)

    operation = cond do
      opCode == 1 -> Operation.new(opCode, param1Index, param2Index, map[index + 3])
      opCode == 2 -> Operation.new(opCode, param1Index, param2Index, map[index + 3])
      opCode == 3 -> Operation.new(opCode, map[index + 1])
      opCode == 4 -> Operation.new(opCode, param1Index)
      opCode == 5 -> Operation.new(opCode, param1Index, param2Index)
      opCode == 6 -> Operation.new(opCode, param1Index, param2Index)
      opCode == 7 -> Operation.new(opCode, param1Index, param2Index, map[index + 3])
      opCode == 8 -> Operation.new(opCode, param1Index, param2Index, map[index + 3])
      opCode == 99 -> Operation.new(opCode)
      true -> raise "Operation cannot be found: " <> Integer.to_string(opCode)
    end

    nextIndex = cond do
      opCode == 1 -> index + 4
      opCode == 2 -> index + 4
      opCode == 3 -> index + 2
      opCode == 4 -> index + 2
      opCode == 5 -> index + 3
      opCode == 6 -> index + 3
      opCode == 7 -> index + 4
      opCode == 8 -> index + 4
      opCode == 99 -> 0
    end

#    IO.inspect(operation)

    {operation, nextIndex}
  end

  def analyze_opcode(op) do
    opCode = rem(op, 100)
    c = div(op, 10000)
    b = div((op - c * 10000), 1000)
    a = div((op - c * 10000 - b * 1000), 100)
    {opCode, a, b, c}
  end

  defp get_index_by_mode(map, index, mode) when mode == 0 do
    map[index]
  end

  defp get_index_by_mode(_, index, mode) when mode == 1 do
    index
  end

  ### Depth first approach. ###
  #  defp map_to_operations(map, index) do
  #    map_to_operations(map, index, [])
  #  end
  #
  #  defp map_to_operations(map, index, operations) when index == -1 do
  #    IO.inspect("end")
  #    Enum.reverse(operations)
  #  end
  #
  #  defp map_to_operations(map, index, operations) do
  #
  #    {operation, nextIndex} = map_to_operation(map, index)
  #
  #    operations = [operation | operations]
  #    map_to_operations(map, nextIndex, operations)
  #  end
end

