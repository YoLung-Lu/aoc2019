defmodule LineWalker do
  # Return the overall distance walk to a point.
  # nil when point NOT on the line.
  def findPointDistanceOnLine([x, y| nextList], targetPoint, currentPoint \\ [0,0], currentDistance \\ 0) do
    [tx, ty] = targetPoint
    [cx, cy] = currentPoint

    cond do
      (ty == cy) && (MathUtil.inBetween(tx, cx, cx + x)) ->
        # IO.inspect("case1: Find intercept on x movement")
        currentDistance + abs(tx - cx)
      (tx == cx + x) && (MathUtil.inBetween(ty, cy, cy + y)) ->
        # IO.inspect("case2: Find intercept on y movement")
        currentDistance + abs(x) + abs(ty - cy)
      nextList == [] ->
        IO.inspect("case5: Cannot find point on line!")
        nil
      length(nextList) == 1 ->
        # IO.inspect("case3: end in x direction, will add a '0' movement for y.")
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
      end)
    |> Enum.filter(fn list -> StructureUtil.notEmptyList(list) end)
  
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
      end)
    |> Enum.filter(fn list -> StructureUtil.notEmptyList(list) end)

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

    line1 = cond do
      String.first(hd(line1)) == "U" || String.first(hd(line1)) == "D" -> 
        ["R0" | line1]
      true -> line1
    end 

    line2 = cond do
      String.first(hd(line2)) == "U" || String.first(hd(line2)) == "D" -> 
        ["R0" | line2]
      true -> line2
    end 

    line1List = Enum.map(line1, &stringLineToInt/1)
    line2List = Enum.map(line2, &stringLineToInt/1)

    {line1MapX, line1MapY} = CrossedWires.linesToMapRecursive(line1, 0, %{}, %{}, {0, 0})
    # {line2MapX, line2MapY} = CrossedWires.linesToMapRecursive(line2, 0, %{}, %{}, {0, 0})

    pointList = LineWalker.findPointOnMaps(line2List, line1MapX, line1MapY, [0, 0])
    # pointList2 = LineWalker.findPointOnMaps(line1List, line2MapX, line2MapY, [0, 0])
    
    pointList 
    |> Enum.map(fn points -> 
      cond do
        is_list(points) ->
          [[x, y]] = points
          line1ToPoint = LineWalker.findPointDistanceOnLine(line1List, [x, y])
          line2ToPoint = LineWalker.findPointDistanceOnLine(line2List, [x, y])
          line1ToPoint + line2ToPoint
        true -> 
          IO.inspect("Failed to walk to point")
          nil
      end
    end)
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