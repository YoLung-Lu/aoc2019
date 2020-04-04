defmodule DiagnosticContainer do
  @moduledoc """
  A state container for 7-1 to get the diagnostic code.
  """

  defstruct listItem: []

  def set(list) do
    %DiagnosticContainer{listItem: list}
  end

  def get(container) do
    cond do
      length(container.listItem) == 1 -> {hd(container.listItem), container}
      true ->  {hd(container.listItem), DiagnosticContainer.set(tl(container.listItem))}
    end
  end

  def get_with_nil(container) do
    cond do
      length(container.listItem) == 0 -> {nil, container}
      true ->  {hd(container.listItem), DiagnosticContainer.set(tl(container.listItem))}
    end
  end

end
