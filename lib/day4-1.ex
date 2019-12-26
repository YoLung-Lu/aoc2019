defmodule SecureContainer do
  def filterLongDigits(code) do
    list = String.codepoints(code)
    listUniqueNumber = list |> Enum.uniq |> length
    # TODO: study list to set: https://www.programming-idioms.org/idiom/118/list-to-set/1869/elixir

    cond do 
      listUniqueNumber > 4 -> true
      listUniqueNumber == 4 -> 
        # The case xyzaaa return false
        false == contentStraitChar(list, 3)
      listUniqueNumber == 1 -> false
      listUniqueNumber == 2 -> 
        # Only the case xxyyyy or xxxxyy return true.
        [s1, s2, s3, s4, s5, s6] = list
        (s1 == s2 && s2 != s3) || (s4 != s5 && s5 == s6)
      listUniqueNumber == 3 -> 
        # Only the case NO any 4 strait char return true.
        (false == contentStraitChar(list, 4)) || (true == contentStraitChar(list, 2))
    end
  end

  def contentStraitChar(code, count) do
    # TODO: regex not working? https://stackoverflow.com/questions/8880088/regular-expression-to-match-3-or-more-consecutive-sequential-characters-and-cons
    # String.match?(code, ~r/(?i)(?:([a-z0-9])\1{3,})*/)
    Enum.any?(code, fn x -> Enum.count(code, &(&1 == x)) == count end)
  end

  def checkCode(code) do
    cond do
      String.length(code) != 6 ->
        nil
      true ->
        result = checkCodeRecursive(code)
        cond do 
          result ->
            # IO.inspect(code)
            code
          true ->
            nil
        end
    end
  end

  defp checkCodeRecursive(code, beforeDigit \\ 0, metAdjacent \\ false) do
    {head, tail} = MathUtil.separateHead(code)

    # IO.inspect(code)
    # IO.inspect(tail)
    cond do
      tail == nil ->
        # IO.inspect("case1")
        (head >= beforeDigit) && (metAdjacent || head == beforeDigit)
      head < beforeDigit -> 
        # IO.inspect("case2")
        false
      head == beforeDigit -> 
        # IO.inspect("case3")
        checkCodeRecursive(tail, head, true)
      head > beforeDigit -> 
        # IO.inspect("case4")
        checkCodeRecursive(tail, head, metAdjacent)
    end
  end  
end