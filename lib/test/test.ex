defmodule MyList do
  def delete_all(list, el) do
    delete_all(list, el, [])
  end

  def delete_all([head | tail], el, new_list) when head === el do
    delete_all(tail, el, new_list)
  end

  # Add the head directly, will make the output list reversed.
  def delete_all([head | tail], el, new_list) do
    delete_all(tail, el, [head | new_list])
  end

  def delete_all([], el, new_list) do
    Enum.reverse(new_list)
  end
end

defmodule MyList2 do
  def delete_all(list, el) do
    delete_all(list, el, [])
  end

  def delete_all([head | tail], el, new_list) when head === el do
    delete_all(tail, el, new_list)
  end

  # Add the head after the return is construct.
  def delete_all([head | tail], el, new_list) do
    [head | delete_all(tail, el, new_list)]
  end

  def delete_all([], el, new_list) do
    new_list
  end
end