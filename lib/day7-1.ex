
defmodule AmplificationCircuit do

  # 7-1
  def runSequentially(inputStr) do
    MathUtil.generateSequenceNumber(5, 4..0)
    |> Enum.map(fn x ->
      runEach(inputStr, x, {inputStr, 0})
    end)
    |> Enum.map(fn x ->
      {_, value} = x
      value
    end)
    |> Enum.max
  end

  defp runEach(inputStr, [hd | tl], output) do
    {_, outputValue} = output
    value = [hd] ++ [outputValue]
    runEach(inputStr, tl, IntCode.run(inputStr, DiagnosticContainer.set(value)))
  end

  defp runEach(_, [], output) do
    output
  end
end

