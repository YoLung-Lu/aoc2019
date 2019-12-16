
defmodule IntCode do
  def run(list) do
    index = 0
    opcode = getOpcode(list, index)
    executeCommand(list, index, opcode)
  end

  # defp executeCommand(list, index, opcode) when opcode == 1 do
  #   IO.puts("current index: " <> Integer.to_string(index))
  #   IO.puts("opcode: " <> Integer.to_string(opcode))

  #   cond do
  #     opcode == 1 -> 
  #       # IO.puts(Enum.at(list, index + 1))
  #       sum = listIndexValue(list, index + 1) + listIndexValue(list, index + 2)
  #       List.replace_at(list, index + 3, sum)
  #       IO.puts(sum)
  #       IO.puts(Enum.at(list, index + 3))
  #       executeCommand(list, index + 4)
  #     opcode == 2 -> 
  #       # IO.puts(Enum.at(list, index + 1))
  #       multiply = listIndexValue(list, index + 1) * listIndexValue(list, index + 2)
  #       List.replace_at(list, index + 3, multiply)
  #       IO.puts(multiply)
  #       IO.puts(Enum.at(list, index + 3))
  #       executeCommand(list, index + 4)
  #     opcode == 99 -> list
  #   end
  # end

  # TODO: Don't use List structure, its too expensive to update...
  defp executeCommand(list, index, opcode) when opcode == 1 do
    # printOpInfo(list, index, opcode)

    sum = listIndexValue(list, index + 1) + listIndexValue(list, index + 2)
    target = Enum.at(list, index + 3)
    list = List.replace_at(list, target, sum)
    executeCommand(list, index + 4, getOpcode(list, index + 4))
  end

  defp executeCommand(list, index, opcode) when opcode == 2 do
  # printOpInfo(list, index, opcode)

    multiply = listIndexValue(list, index + 1) * listIndexValue(list, index + 2)
    target = Enum.at(list, index + 3)
    list = List.replace_at(list, target, multiply)
    executeCommand(list, index + 4, getOpcode(list, index + 4))
  end

  defp executeCommand(list, index, opcode) when opcode == 99 do
    printOpInfo(list, index, opcode)
    list
  end

  defp printOpInfo(list, index, opcode) do
    value1 = listIndexValue(list, index + 1)
    value2 = listIndexValue(list, index + 2)
    target = Enum.at(list, index + 3)
    IO.puts("current index: " <> Integer.to_string(index))
    IO.puts("opcode: " <> Integer.to_string(opcode))
    IO.puts("value1: " <> Integer.to_string(value1))
    IO.puts("value2: " <> Integer.to_string(value2))
    IO.puts("target: " <> Integer.to_string(target))
    IO.puts("--------------")
  end 

  defp getOpcode(list, index) do 
    opcode = Enum.at(list, index)
  end

  defp listIndexValue(list, index) do
      valueIndex = Enum.at(list, index)
      Enum.at(list, valueIndex)
  end 
end