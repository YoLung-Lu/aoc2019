# AOC2019

**TODO: Add description**

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `aoc2019` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:aoc2019, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/aoc2019](https://hexdocs.pm/aoc2019).


## Notes

### Setup App, Module

[App](https://elixir-lang.org/getting-started/mix-otp/introduction-to-mix.html)
[CaptureOp](https://dockyard.com/blog/2016/08/05/understand-capture-operator-in-elixir)

TODO: multiple return value?

* Compile project
`iex -S mix`

### Day1

* Pipe function -> first param is the piped data

### Day3

* Scope within the `cond do` cannot be apply to outside. So the assignment will NOT be successed.
  * Lexical scoping
  * Pin operator
https://elixirforum.com/t/how-to-assignment-in-the-case-condition/22612
https://whatis.techtarget.com/definition/lexical-scoping-static-scoping
https://elixirschool.com/en/lessons/basics/pattern-matching/


https://dev.to/leolanese/functional-programming-buzzwords-36c1