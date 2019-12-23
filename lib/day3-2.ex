defmodule LineWalker do
  # Return the overall distance walk to a point.
  # nil when point NOT on the line.
  def findPointDistanceOnLine([x, y| nextList], targetPoint, currentPoint, currentDistance) do
    [tx, ty] = targetPoint
    [cx, cy] = currentPoint

    cond do
      (ty == cy) && (MathUtil.inBetween(tx, cx, cx + x)) ->
        # IO.inspect("case1")
        currentDistance + abs(tx - cx)
      (tx == cx + x) && (MathUtil.inBetween(ty, cy, cy + y)) ->
        # IO.inspect("case2")
        currentDistance + abs(x) + abs(ty - cy)
      nextList == [] ->
        IO.inspect("Cannot find point on line!")
        nil
      length(nextList) == 1 ->
        # case of end in x
        findPointDistanceOnLine(nextList ++ [0], targetPoint, [cx + x, cy + y], currentDistance + abs(x) + abs(y))
      true ->
        # IO.inspect("case4")
        findPointDistanceOnLine(nextList, targetPoint, [cx + x, cy + y], currentDistance + abs(x) + abs(y))
    end
  end

  def findPointOnMaps([x, y | nextLines], line1MapX, line1MapY, currentPoint) do
    [cx, cy] = currentPoint

    keysX = Map.keys(line1MapX)
    keysY = Map.keys(line1MapY)

    # IO.inspect(line1MapX)
    point = [x, y]
    # IO.inspect(point)

    interceptX = keysX
    |> Enum.filter(fn key -> MathUtil.inBetween(key, cx, cx + x) end)
    |> Enum.map(fn key -> 
        Map.get(line1MapX, key)
        |> Enum.map(fn value -> 
          [startY, endY] = value
          cond do
            MathUtil.inBetween(cy, startY, endY) -> 
              [key, cy]
            true -> nil
          end
        end)
        |> Enum.filter(fn list -> list != nil && is_list(list) && list != [] end)
      end)
    |> Enum.filter(fn list -> list != nil && list != [nil] && list != [] end)
  
    interceptY = keysY
    |> Enum.filter(fn key -> MathUtil.inBetween(key, cy, cy + y) end)
    |> Enum.map(fn key -> 
        Map.get(line1MapY, key)
        |> Enum.map(fn value -> 
          [startX, endX] = value
          cond do
            MathUtil.inBetween(cx + x, startX, endX) -> 
              [cx + x, key]
            true -> nil
          end
        end)
        |> Enum.filter(fn list -> list != nil && is_list(list) && list != [] end)
      end)
    |> Enum.filter(fn list -> list != nil && list != [nil] && list != [] end)

    returnValue = interceptX ++ interceptY

    cond do
      nextLines == [] ->
        returnValue
      length(nextLines) == 1 ->
        returnValue ++ findPointOnMaps(nextLines ++ [0], line1MapX, line1MapY, [cx + x, cy + y])
      true ->
        returnValue ++ findPointOnMaps(nextLines, line1MapX, line1MapY, [cx + x, cy + y])
    end
  end
end

defmodule CrossedWires2 do
  
  def createLineList(inputList) do

    line1 = hd(inputList)
    line2 = hd(tl(inputList))

    line1List = Enum.map(line1, &stringLineToInt/1)
    line2List = Enum.map(line2, &stringLineToInt/1)
    # line1 |> Enum.map(&stringLineToInt/1)

    {line1MapX, line1MapY} = CrossedWires.linesToMapRecursive(line1, 0, %{}, %{}, {0, 0})
    # {line2MapX, line2MapY} = CrossedWires.linesToMapRecursive(line2, 0, %{}, %{}, {0, 0})
    # IO.inspect(length(Map.keys(line1MapX)))

    pointList = LineWalker.findPointOnMaps(line2List, line1MapX, line1MapY, [0, 0])

    # pointList2 = LineWalker.findPointOnMaps(line1List, line2MapX, line2MapY, [0, 0])
    IO.inspect(pointList)
    # IO.inspect(pointList2)
    
    # IO.inspect(pointList)
    pointList 
    |> Enum.map(fn points -> 
      # IO.inspect(points)
      cond do
        is_list(points) ->
          [[x, y]] = points
          line1ToPoint = LineWalker.findPointDistanceOnLine(line1List, [x, y], [0, 0], 0)
          line2ToPoint = LineWalker.findPointDistanceOnLine(line2List, [x, y], [0, 0], 0)
          # IO.inspect("Walk distance to point:")
          line1ToPoint + line2ToPoint
        true -> 
          IO.inspect("Failed to walk to point")
          nil
      end
    end)
    |> IO.inspect

    # Test
    # LineWalker.findPointDistanceOnLine(line1List, [146, 46], [0, 0], 0)
    # |> IO.inspect

    # LineWalker.findPointDistanceOnLine(line2List, [146, 46], [0, 0], 0)
    # |> IO.inspect
  end

  def stringLineToInt(line) do
    {direction, distance} = String.split_at(line, 1)
    distance = String.to_integer(distance)

    cond do
      direction == "R" || direction == "U" -> 
        distance
      direction == "L" || direction == "D" ->
        -1 * distance
    end
  end
end