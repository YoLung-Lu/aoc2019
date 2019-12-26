# import Util
# import FuelCounter
# Code.load_file("lib/FileUtil.ex")
# Code.load_file("lib/day1.ex")
# import CrossedWires2
import SecureContainer

defmodule App do

  def day51(input \\ "input/day5.txt", output \\ "output/day5-1.txt") do
    FileUtil.readFile(input)
    |> String.split(",")
    |> Enum.map(&String.to_integer/1)
    # |> List.replace_at(1, 12) 
    # |> List.replace_at(2, 2)
    # |> List.replace_at(1, 93)
    # |> List.replace_at(2, 42)
    |> DiagnosticProgram.run
    # Answer 2-1 ##
    |> MyLog.log(&(List.first/1)) 
    |> MyLog.logToFile(output)
  end

  def day41 do
    # Enum.to_list(206938..233345)
    Enum.to_list(206938..679128)
    |> Enum.map(&Integer.to_string(&1))
    |> Enum.map(&SecureContainer.checkCode(&1))
    |> Enum.filter(fn x -> x != nil end)
    # Answer for 4-1: 1653
    |> MyLog.log(&(length/1))
    |> Enum.map(&SecureContainer.filterLongDigits(&1))
    # |> IO.inspect
    |> Enum.filter(fn x -> x end)
    # Answer for 4-2: 1133
    |> MyLog.log(&(length/1))
  end

  def day32(file \\ "input/day3.txt") do 
    FileUtil.readFile(file)
    |> String.split("\n")
    |> Enum.map(&String.split(&1, ","))
    |> CrossedWires2.createLineList
    |> Enum.filter(fn x -> x > 0 end)
    |> Enum.min
    |> IO.inspect
    |> MyLog.logToFile("output/day3-2.txt")
  end

  def day3 do 
    FileUtil.readFile("input/day3.txt")
    # FileUtil.readFile("input/day3test.txt")
    |> String.split("\n")
    |> Enum.map(&String.split(&1, ","))
    # |> Enum.map(&MyLog.log(&1))
    |> CrossedWires.createMap
    |> IO.inspect
    |> MyLog.logToFile("output/day3-1.txt")
    # |> Enum.map(&MyLog.log(&1))
  end

  def day2 do
    FileUtil.readFile("input/day2.txt")
    |> String.split(",")
    |> Enum.map(&String.to_integer/1)
    |> List.replace_at(1, 12) 
    |> List.replace_at(2, 2)
    # |> List.replace_at(1, 93)
    # |> List.replace_at(2, 42)
    |> IntCode.run
    # Answer 2-1 ##
    |> MyLog.log(&(List.first/1)) 
    |> MyLog.logToFile("output/day2-1.txt")

  end
  def day1 do
    input = FileUtil.readFileInList "input/day1.txt"
    # input = [100, 30]
    output = FuelCounter.fuelSumByFunction3 input
    ## Answer 1-1 ##
    outputSum = Enum.sum(output)
    FileUtil.writeToFile(outputSum, "output/day1-1.txt")


    targetFunction = &FuelCounter.fuelFromMass/1
    stopFunction = fn input -> input <= 0 end

    output
    |> Enum.map(&MathUtil.recursiveUntil(
      &1,
      targetFunction,
      stopFunction
    ))
    |> Enum.map(&Enum.sum(&1))
    |> Enum.sum
    ## Answer 1-2 ##
    |> PipeUtil.sideEffect(&FileUtil.writeToFile(&1, "output/day1-2.txt"))
    |> IO.puts
  end

  def day1Function do

    targetFunction = &FuelCounter.fuelFromMass/1
    stopFunction = fn input -> input <= 0 end

    FileUtil.readFileInList("input/day1.txt")
    |> FuelCounter.fuelSumByFunction3
    ## Answer 1-1 ##
    |> MyLog.logToFile(&Enum.sum/1, "output/day1-1.txt")
    # |> MyLog.log(Enum.sum(&1))
    # |> PipeUtil.sideEffect(&FileUtil.writeToFile(Enum.sum(&1), "output/day1-1.txt"))
    |> Enum.map(&MathUtil.recursiveUntil(
      &1,
      targetFunction,
      stopFunction
    ))
    |> Enum.map(&Enum.sum(&1))
    |> Enum.sum
    ## Answer 1-2 ##
    |> MyLog.logToFile("output/day1-2.txt")
    # |> MyLog.log
    # |> PipeUtil.sideEffect(&FileUtil.writeToFile(&1, "output/day1-2.txt"))
    # |> IO.puts
  end
end 

# App.day1Function()
# App.day3()
# App.day32()
# App.day41()


# command:
# Compile project
# iex -S mix
# iex -r *.exs
# c "lib/app.exs"
# ctrl + C
# elixir Util.exs