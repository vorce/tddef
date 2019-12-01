defmodule Kex.Check.FunctionCall do
  @moduledoc """
  Check that the function defined by tddef is called in a test.
  """

  def check!(
        caller,
        {:when, _,
         [
           {name, _, args},
           _
         ]}
      ) do
    check!(caller, {name, [], args})
  end

  def check!(caller, {name, _, args}) do
    IO.inspect(binding(), label: "args")
    arity = length(args)
    function = {name, arity}
    :ok
  end
end
