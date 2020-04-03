
defmodule IntCode do
  def run(list) do
    list
    |> StructureUtil.list_to_indexed_map(0)
    |> loop_through_operation
    |> StructureUtil.indexed_map_to_list(0)
    |> Enum.join(",")
#    |> IO.inspect

  end

  defp loop_through_operation(map) do
    loop_through_operation(map, 0, StateExecution.continue())
  end

  defp loop_through_operation(map, index, %StateExecution{state: 99}) do
#    IO.inspect(map[index])
#    IO.inspect("stop")
    map
  end

  defp loop_through_operation(map, index, _) do
    {operation, nextIndex} = map_to_operation(map, index)
    {map, nextState} = execute_operation(operation, map)
    loop_through_operation(map, nextIndex, nextState)
  end

  defp execute_operation(%Operation{opCode: 1} = operation, map) do
    sumValue = map[operation.param1] + map[operation.param2]
    map = Map.merge(map, %{operation.param3 => sumValue})
    {map, StateExecution.continue()}
  end

  defp execute_operation(%Operation{opCode: 2} = operation, map) do
    multiplyValue = map[operation.param1] * map[operation.param2]
    map = Map.merge(map, %{operation.param3 => multiplyValue})
    {map, StateExecution.continue()}
  end

  defp execute_operation(%Operation{opCode: 99} = operation, map) do
    {map, StateExecution.halt()}
  end

  defp map_to_operation(map, index) do
    opCode = map[index]

    operation = cond do
      opCode == 1 -> Operation.new(opCode, map[index + 1], map[index + 2], map[index + 3])
      opCode == 2 -> Operation.new(opCode, map[index + 1], map[index + 2], map[index + 3])
      opCode == 99 -> Operation.new(opCode)
    end

    nextIndex = cond do
      opCode == 1 -> index + 4
      opCode == 2 -> index + 4
      opCode == 99 -> 0
    end

    {operation, nextIndex}
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

