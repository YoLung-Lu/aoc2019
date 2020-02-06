# import Util

defmodule FuelCounter do
  def fuelSum(massList) do
    for n <- massList, do: fuelFromMass(n)
  end

  def fuelFromMass(mass) do
    cond do
        mass > 2 -> div(mass, 3) - 2
        true     -> 0
    end
  end

  def fuelSumByFunction(massList) do
    Enum.each massList, &FuelCounter.fuelFromMass/1
  end

  def fuelSumByFunction2(massList) do
    Enum.map(massList, fn x -> div(x, 3) - 2 end)
  end

  def fuelSumByFunction3(massList) do
    massList
      |> Enum.map(fn x ->  div(x, 3) - 2 end)
  end

  def fuelSumByFunction4(massList) do
    massList
    |> Enum.map(&FuelCounter.fuelFromMass/1)
    |> Enum.each(&IO.puts/1)
  end
end

defmodule FuelCounterV2 do
  def fuelFromMass(mass) when mass <= 5, do: 0
  def fuelFromMass(mass) do
    fuel = div(mass, 3) - 2
    fuel + fuelFromMass(fuel)
  end
end

defmodule FuelCounterV3 do
  def fuelFromMass(mass), do: fuelFromMass(mass, 0)
  def fuelFromMass(mass, acc) when mass <= 5, do: acc
  def fuelFromMass(mass, acc) do
    fuel = div(mass, 3) - 2
    fuelFromMass(fuel, acc + fuel)
  end
end

# Test.
#FuelCounter.fuelSumByFunction4 [5, 10, 15, 20, 25, 30]

# Day1.
# input = Util.readFileInList "../input/day1.txt"
# IO.puts(["list is: \n", Enum.join(input, "\n")])
# output = FuelCounter.fuelSumByFunction3 input
# IO.puts(["list is: \n", Enum.join(output, "\n")])
# Util.writeListToFile("../output/day1.txt", output)
# outputSum = Enum.sum(output)
# IO.puts(outputSum)
# Util.writeToFile("../output/day1-1.txt", outputSum)