defmodule Operation do
  @moduledoc false

  #@enforce_keys [:opCode]
  @invalid -1
  defstruct opCode: @invalid, param1: @invalid, param2: @invalid, param3: @invalid

  def new(opCode, param1 \\ @invalid, param2 \\ @invalid, param3 \\ @invalid) do
    %Operation{opCode: opCode, param1: param1, param2: param2, param3: param3}
  end

  # TODO: uncertain number of key-value creation.
#  def new(keyList) do
#    new(keyList, %Operation{})
#  end
#
#  defp new([head|tail], operation) do
#    new(tail, update_key(head, operation))
#  end
#
#  defp new([], operation) do
#    operation
#  end
#
#  defp update_key(keyValue, operation) do
##    %{key: value} = keyValue
#
#    key = keyValue.keys()
#    operation = cond do
#      Map.has_key?(operation, key) -> Map.merge(keyValue, operation)
#      true -> operation
#    end
#
#    operation
#  end

end