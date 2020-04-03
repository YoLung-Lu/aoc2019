defmodule StateExecution do
  @continue 1
  @out 2
  @halt 99

  defstruct state: @continue

  def new() do
    %StateExecution{state: @continue}
  end

  def continue() do
    %StateExecution{state: @continue}
  end

  def halt() do
    %StateExecution{state: @halt}
  end

  def is_halt(state) do
    state.state == @halt
  end
end
