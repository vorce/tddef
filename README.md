# tddef

**tddef** is a tool meant to help you do test driven development.

tddef checks that your code is covered by tests. If it's not compilation will fail with a helpful message guiding you in the TDD process.

## Usage

- Add dependency, `mix deps.get`
- Add `use Tddef` to the module you want to get assistance in driving with TDD.

## Example

TODO: Ascii gif

## Details

tddef works by wrapping the `def` keyword in Elixir. Before allowing you to define your function it will
check that you have a test for it.

This little helper started as a project to learn more about macros in Elixir.

### Rationale

There was a thread on twitter about ideas for programming languages. Someone said that they would like to explore a language that forces you to write tests. I thought that was an interesting idea, and figured it could be implemented as a macro for Elixir.

## Installation

tddef is available in Hex, the package can be installed
by adding `tddef` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:tddef, "~> 0.1.0"}
  ]
end
```

Documentation is generated with [ExDoc](https://github.com/elixir-lang/ex_doc) and can
be found at [https://hexdocs.pm/tddef](https://hexdocs.pm/tddef).
