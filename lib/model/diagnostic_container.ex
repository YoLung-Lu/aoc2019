defmodule DiagnosticContainer do

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

end
