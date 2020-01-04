defmodule FileUtil do

  def readFile(fileName) do
    {:ok, words} =
      File.read(fileName)
        # |> Enum.map(&String.split(&1, ","))
        # |> Enum.map(&String.to_integer/1)
    words
  end

  def readFileInList(fileName) do
    words =
      File.stream!(fileName)
        |> Stream.map(&String.trim_trailing/1)
        |> Enum.to_list
        |> Enum.map(&String.to_integer/1)

    words
  end

  def writeToFile(content, fileName) do
    {:ok, file} = File.open fileName, [:write]
    IO.write(file, content)
  end 

  def writeListToFile(list, fileName) do
    {:ok, file} = File.open fileName, [:write]
    # list
      # |> Enum.map(fn line -> line <> "\n" end)
      # |> Enum.map(fn line -> IO.write(file, line) end)
    IO.write(file, Enum.join(list, "\n"))
  end 
end

defmodule PipeUtil do
  def sideEffect(input, sideEffectFunction) do
    sideEffectFunction.(input)
    input
  end
end

defmodule MyLog do
  def log(input) do
    printString = getString(input)
    IO.puts("Logger: " <> printString)
    input
  end

  def log(input, sideEffectFunc) do
    output = sideEffectFunc.(input)
    printString = getString(output)
    IO.puts("Logger: " <> printString)
    input
  end

  def logToFile(input, sideEffectFunc, fileName) do
    output = sideEffectFunc.(input)
    FileUtil.writeToFile(getString(output), fileName)
    input
  end

  def logToFile(input, fileName) do
    FileUtil.writeToFile(getString(input), fileName)
    input
  end

  defp getString(input) when is_list(input) do
    IO.puts("list")
    Enum.join(input, ", ")
  end

  defp getString(input) when is_integer(input) do
    IO.puts("integer")
    Integer.to_string(input)
  end

  defp getString(input) when is_binary(input) do
    IO.puts("string")
    input
  end 
end

defmodule MathUtil do
  def findMinInList(list) do
    cond do
      list == [] -> nil
      true -> Enum.min(list)
    end 
  end

  def separateHead(str) do
    cond do
      str == nil ->
        {nil, nil}
      String.length(str) == 1 ->
        {String.to_integer(str), nil}
      true ->
        len = String.length(str)
        int = String.to_integer(str)
        tenx = :math.pow(10,(len - 1)) |> round
        head = Integer.floor_div(int, tenx)
        tail = String.slice(str, 1..-1)
        {head, tail}
    end
  end

  def generateSequenceNumber(size, range) do
    combinations(size, range)
  end

  # Reference: https://elixirforum.com/t/generate-all-combinations-having-a-fixed-array-size/26196/5
  defp combinations(size, range) do
    combinations(size, range, (for x <- range, do: [x]))
  end

  defp combinations(1, range, acc), do: acc

  defp combinations(size, range, acc) do
    combinations(size - 1, range, (for x <- range, y <- acc, !Enum.member?(y, x), do: [x | y]))
  end

  # TODO: Why not working?
  # def separateHead() do
  #   {nil, nil}
  # end
  
  def inBetween(value, range1, range2) do
    (range1 <= value && value <= range2) || 
    (range2 <= value && value <= range1)
  end

  def findSmallerPoint(point1, point2) do
    [x1, y1] = point1
    [x2, y2] = point2
    d1 = x1*x1 + y1*y1
    d2 = x2*x2 + y2*y2

    cond do
      d1 <= d2 -> point1
      true -> point2
    end

  end
  # def mergeListRange(lists1, list2) do
  #   min2 = hd(list2)
  #   max2 = tl(list2)
  #   Enum
  #   cond do
  #     (min1 > max2) || (min2 > max1) ->
  #       list1 ++ list2
  #   end 
  # end

  def recursiveUntil(input, targetFunction, stopFunction) do
    # IO.puts("input: "<> Integer.to_string(input))
    output = 
    case stopFunction.(input) do 
      true -> []
      _ -> 
        next = targetFunction.(input)
        sub = recursiveUntil(next, targetFunction, stopFunction)
        # IO.puts(["sub is: \n", Enum.join(sub, "\n")])
        # output = [input | sub]
        [input | sub]
    end
    # IO.puts(["Output is: \n", Enum.join(output, "\n")])
    output
  end
end

defmodule StructureUtil do
  def notEmptyList(list) do
    list != nil && 
    is_list(list) && 
    list != [] &&
    list != [nil]
  end
end

defmodule TestUtil do
  def combinations(0, _), do: [[]]
  def combinations(_, []), do: []
  def combinations(size, [head | tail]) do 
      (for elem <- combinations(size-1, tail), do: [head|elem]) ++ combinations(size, tail)
  end
end