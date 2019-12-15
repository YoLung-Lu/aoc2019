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
    Enum.join(input, ", ")
  end

  defp getString(input) when is_integer(input) do
    Integer.to_string(input)
  end

  defp getString(input) when is_binary(input) do
    input
  end 
end

defmodule MathUtil do
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

# Test case
# words = Util.readFileInList "../input/day1.txt"
# IO.puts(["list is: \n", Enum.join(words, "\n")])
# Util.writeListToFile("../output/day1.txt", words)