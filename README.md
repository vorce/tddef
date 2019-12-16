# Kex

Kex is a tool meant to help you do test driven development.

Kex checks that your code is covered by tests. If it's not compilation will fail with a helpful message guiding you in the TDD process.

## Usage

- Add dependency, `mix deps.get`
- Add `use Kex` to the module you want to get assistance in driving with TDD.

## Example

TODO: Ascii gif

## Details

Kex works by wrapping the `def` keyword in Elixir. Before allowing you to define your function it will
check that you have a test for it.

This little helper started as a project to learn more about macros in Elixir.

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `kex` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:kex, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/kex](https://hexdocs.pm/kex).

