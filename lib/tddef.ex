defmodule Tddef do
  @moduledoc """
  Tddef is a macro that aims to guide you in the TDD process.
  It will perform some compile time checks on any function you `def`
  to ensure there is a test.
  """

  defmacro __using__(_opts) do
    quote do
      import Tddef
      import Kernel, except: [def: 2]
    end
  end

  @doc """
  The main macro for Tddef.

  Use this in any module you want assistance on
  for doing TDD. It will check that your function is
  called in a test.

  Example:

      use Tddef

      def myfunction(foo) do
        # ...
      end
  """
  defmacro def(name, body) do
    {:ok, meta} = Tddef.Check.TestFile.check!(__CALLER__, name)
    :ok = Tddef.Check.FunctionCall.check!(__CALLER__, name, meta)

    quote do
      Kernel.def(unquote(name), unquote(body))
    end
  end
end
