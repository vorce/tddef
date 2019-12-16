defmodule Tddef do
  @moduledoc """
  Documentation for Tddef.
  """

  defmacro __using__(_opts) do
    quote do
      import Tddef
      import Kernel, except: [def: 2]
    end
  end

  defmacro def(name, body) do
    # IO.inspect(binding(), label: "def args")

    {:ok, meta} = Tddef.Check.TestFile.check!(__CALLER__, name)
    :ok = Tddef.Check.FunctionCall.check!(__CALLER__, name, meta)

    quote do
      Kernel.def(unquote(name), unquote(body))
    end
  end
end
