
defmodule AmplificationCircuit do
  @moduledoc """
  A domain layer build on top of `IntCode` to run the
  Amplification in different cases.
  """

  # 7-2
  def run_with_random_sequence_phase_setting(inputStr) do
    MathUtil.generateSequenceNumber(5, 9..5)
    |> Enum.map(fn x ->
      runFeedbackLoop(inputStr, x)
    end)
    |> Enum.max
  end

  # For test case.
  # phaseSettingList = [9,8,7,6,5]
  def runFeedbackLoop(inputStr, phaseSettingList) do
    map = inputStr
    |> String.split(",")
    |> Enum.map(&String.to_integer/1)
    |> StructureUtil.list_to_indexed_map(0)

    phaseSetting = StructureUtil.list_to_indexed_map(phaseSettingList, 0)
    firstLoopInput = StructureUtil.list_to_indexed_map([map, map, map, map, map], 0)
    outputState = StructureUtil.list_to_indexed_map([nil,nil,nil,nil,nil], 0)

    active_amplifiers(0, firstLoopInput, phaseSetting, outputState)
    |> Map.get(:output)
  end

  def active_amplifiers(index, maps, phaseSettings, states, lastOutputState \\ OperationExecutionState.fake()) do
    lastOutput = Map.get(lastOutputState, :output)

    # Generate input state.
    state = Map.get(states, index)
    state = cond do
      state == nil ->
        firstDiagnostic = [Map.get(phaseSettings, index), lastOutput]
        OperationExecutionState.new(0, DiagnosticContainer.set(firstDiagnostic))
      true ->
        diagnostic = [lastOutput]
        OperationExecutionState.continue(state, DiagnosticContainer.set(diagnostic))
    end

#    IO.inspect("Input state")
#    IO.inspect(state)

    # Execution.
    outputState = IntCode.run_with_state(Map.get(maps, index), state)

    # Handle state update.
    maps = Map.merge(maps, %{index => Map.get(outputState, :map)})
    states = Map.merge(states, %{index => outputState})

#    IO.inspect("Output state")
#    IO.inspect(outputState)

    cond do
      # Halt condition.
      Map.get(outputState, :state) == 99 && index == 4 -> outputState
      # Continue.
      true -> active_amplifiers(MathUtil.int_in_range(index + 1, 5), maps, phaseSettings, states, outputState)
    end
  end


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

