defmodule OrbitMap do
  def meAndSan(list) do
    mapList = list
    |> Enum.map(fn x -> 
      [parent, child] = String.split(x, ")")
      %{child => parent}
      end)
    
    map = Enum.reduce(mapList, fn x, y ->
      Map.merge(x, y, fn _k, v1, v2 -> v2 ++ v1 end)
    end)
    
    me = Map.take(map, ["YOU"])
    san = Map.take(map, ["SAN"])

    myPath = walkPath(me, map, [])
    sanPath = walkPath(san, map, [])
    IO.inspect(length(myPath))
    IO.inspect(length(sanPath))

    deltaMe = length(myPath -- sanPath)
    deltaSan = length(sanPath -- myPath)

    IO.inspect(deltaMe + deltaSan)



  end

  def run(list) do
    list
    |> Enum.map(fn x -> 
      [parent, child] = String.split(x, ")")
      %{child => parent}
      end)
    |> walkPath
    |> List.flatten
    |> length
    |> IO.inspect
  end

  def walkPath(list) do
    map = Enum.reduce(list, fn x, y ->
      Map.merge(x, y, fn _k, v1, v2 -> v2 ++ v1 end)
    end)

    Enum.map(list, fn pair -> 
      walkPath(pair, map, [])
    end)
  end

  def walkPath(pair, map, pathList) do
    value = hd(Map.values(pair))
    cond do
      Map.has_key?(map, value) -> 
        nextPair = Map.take(map, [value])
        walkPath(nextPair, map, [value| pathList])
      true -> [value| pathList]
    end
  end
end