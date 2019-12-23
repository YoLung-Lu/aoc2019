defmodule CrossedWires do
  def createMap(inputList) do
    # There are 3 elements in the input: [[line1], [line2], []]
    line1 = hd(inputList)
    line2 = hd(tl(inputList))

    {line1MapX, line1MapY} = linesToMapRecursive(line1, 0, %{}, %{}, {0, 0})
    # %{ 5637 => [[7392, 8374]], 6592 => [[3527, 3673]], ...}

    # IO.inspect(line1MapX)
    # IO.inspect(line1MapY)

    intercept = linesInterceptWithMap(line2, 0, Map.keys(line1MapX), line1MapX, {0, 0}, [99999, 99999])
    intercept2 = linesInterceptWithMap(line2, 0, Map.keys(line1MapY), line1MapY, {0, 0}, [99999, 99999])

    inter = MathUtil.findSmallerPoint(intercept, intercept2)
    inter
  end

  def linesInterceptWithMap(lines, index, keys, map, position, intercept) do
    line = Enum.at(lines, index)
    {direction, distance} = stringToLine(line)
    {x, y} = position

    positionAfter = walkToPoint(position, direction, distance)
    {x2, y2} = positionAfter
    interceptNew = cond do
      (direction == "R") || (direction == "L") -> 
        minX = keys
        |> Enum.filter(fn key -> MathUtil.inBetween(key, x, x2) end)
        |> MathUtil.findMinInList
        [minX, y2]
        # intercept
      (direction == "U") || (direction == "D") ->
        minY = keys
        |> Enum.filter(fn key -> MathUtil.inBetween(key, y, y2) end)
        |> MathUtil.findMinInList
        [x2, minY]
    end

    [xNew, yNew] = interceptNew
    intercept = cond do 
      xNew != nil && yNew != nil ->
        # IO.inspect(interceptNew)
        MathUtil.findSmallerPoint(intercept, interceptNew)
      true ->
        intercept
    end

    size = Enum.count(lines)
    index = index + 1
    cond do
      size <= index -> 
        intercept
      true -> 
        linesInterceptWithMap(lines, index, keys, map, positionAfter, intercept)
    end 
  end

  def linesToMapRecursive(lines, index, mapX, mapY, position) do
    line = Enum.at(lines, index)
    {direction, distance} = stringToLine(line)
    {x, y} = position

    {mapX, mapY, position} = walkDirection(mapX, mapY, position, direction, distance)
    size = Enum.count(lines)
    index = index + 1
    cond do
      size <= index -> 
        {mapX, mapY}
      true -> 
        linesToMapRecursive(lines, index, mapX, mapY, position)
    end 
  end

  def linesToMap(lines) do
    position = {0, 0}
    map = %{}

    Enum.each(lines, fn(s) ->
        {outputMap, outputPosition} = lineToMap({s, position})

        # ^map = outputMap
        ^position = outputPosition

        map
      end
    )
    # |> IO.inspect

    # lines
    # |> Enum.each({&1, position})
    # |> Enum.map(&lineToMap({&1, position}))
    # |> IO.inspect
  end

  def lineToMap(input) do
    {line, position} = input
    map = %{}
    {direction, distance} = String.split_at(line, 1)
    distance = String.to_integer(distance)
    {x, y} = position
    
    {map, position} = cond do 
      direction == "R" -> 
        map = mapMergeListValue(map, y, [x, x + distance])
        position = {(x + distance), y}
        {map, position}
      direction == "L" ->
        map = mapMergeListValue(map, y, [x - distance, x])
        position = {x - distance, y}
        {map, position}
      direction == "U" ->
        map = mapMergeListValue(map, x, [y, y + distance])
        position = {x, y + distance}
        {map, position}
      direction == "D" ->
        map = mapMergeListValue(map, x, [y - distance, y])
        position = {x, y - distance}
        {map, position}
    end
    # IO.inspect(map)
    # IO.inspect(position)
    {map, position}
  end

  defp walkDirection(mapX, mapY, position, direction, distance) do 
    {x, y} = position
    # TODO: Haven't separate x and y for the map.
    positionAfter = walkToPoint(position, direction, distance)

    {mapX, mapY} = cond do 
      direction == "R" -> 
        mapY = mapMergeListValue(mapY, y, [x, x + distance])
        {mapX, mapY}
      direction == "L" ->
        mapY = mapMergeListValue(mapY, y, [x - distance, x])
        {mapX, mapY}
        # position = {x - distance, y}
        # {map, position}
      direction == "U" ->
        mapX = mapMergeListValue(mapX, x, [y, y + distance])
        {mapX, mapY}
        # position = {x, y + distance}
        # {map, position}
      direction == "D" ->
        mapX = mapMergeListValue(mapX, x, [y - distance, y])
        {mapX, mapY}
        # position = {x, y - distance}
        # {map, position}
    end
    {mapX, mapY, positionAfter}
  end 

  defp walkToPoint(position, direction, distance) do
    {x, y} = position
    cond do 
      direction == "R" -> 
        {(x + distance), y}
      direction == "L" ->
        {x - distance, y}
      direction == "U" ->
        {x, y + distance}
      direction == "D" ->
        {x, y - distance}
    end
  end

  defp stringToLine(string) do
    {direction, distance} = String.split_at(string, 1)
    distance = String.to_integer(distance)
    {direction, distance}
  end

  defp mapMergeListValue(map, key, listValue) do
    # TODO: Implement merge
    # mapValue = map[key]
    # con do 
    #   mapValue != nil ->
    #     mapValue
    #   true ->
    #     Map.put(map, key, listValue)
    # end 
    t = Map.put(map, key, [listValue])
    # IO.inspect(t)
    t
  end

  
end