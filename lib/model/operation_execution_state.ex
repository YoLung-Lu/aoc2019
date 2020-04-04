defmodule OperationExecutionState do
  @continue 1
  @pause 2
  @halt 99

  defstruct state: @continue,
            map: %{},
            index: -1,
            output: 0,
            get_diagnostic: nil

  def new(index, get_diagnostic) do
    %OperationExecutionState{state: @continue, index: index, get_diagnostic: get_diagnostic}
  end

  def continue(state) do
    %OperationExecutionState{state: state.state, index: state.index, get_diagnostic: state.get_diagnostic}
  end

  def continue(state, index) when is_integer(index) do
    %OperationExecutionState{state: state.state, index: index, get_diagnostic: state.get_diagnostic}
  end

  def continue(state, diagnostic) do
    %OperationExecutionState{state: state.state, index: state.index, get_diagnostic: diagnostic}
  end

  def pause(map, index, output) do
    %OperationExecutionState{state: @pause, map: map, index: index, output: output}
  end

  def halt(state) do
    %OperationExecutionState{state: @halt, index: state.index, get_diagnostic: state.get_diagnostic}
  end

  def is_halt(state) do
    state.state == @halt
  end
end
