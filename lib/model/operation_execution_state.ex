defmodule OperationExecutionState do
  @moduledoc """
  A state machine to provide the state for `IntCode` to execute.
  It encapsulate the state through struct, and the use case as interface.
  """

  @continue 1
  @pause 2
  @halt 99

  defstruct state: @continue,
            map: %{},
            index: -1,
            output: 0,
            get_diagnostic: nil

  # Use as initial state.
  def fake() do
    %OperationExecutionState{state: @continue}
  end

  def new(index, get_diagnostic) do
    %OperationExecutionState{state: @continue, index: index, get_diagnostic: get_diagnostic}
  end

  def continue(state, index) when is_integer(index) do
    Map.merge(state, %{:index => index})
  end

  # Op 3
  def continue(state, diagnostic) do
    Map.merge(state, %{:state => @continue, :get_diagnostic => diagnostic})
  end

  # Op 3
  def pause(state, map, index) do
    Map.merge(state, %{:state => @pause, :map => map, :index => index})
  end

  # Op 4
  def continue_with_output(state, output) do
    Map.merge(state, %{:output => output})
  end

  def halt(state, map) do
    Map.merge(state, %{:state => @halt, :map => map})
  end

  def is_halt(state) do
    state.state == @halt
  end

  def get_map(state) do
    state.map
  end
end
