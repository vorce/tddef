defmodule Kex do
  @moduledoc """
  Documentation for Kex.
  """

  defmacro __using__(_opts) do
    quote do
      import Kex
      import Kernel, except: [def: 2]
    end
  end

  defmacro def(name, body) do
    # IO.inspect(binding(), label: "def args")

    {:ok, meta} = Kex.Check.TestFile.check!(__CALLER__, name)
    :ok = Kex.Check.FunctionCall.check!(__CALLER__, name, meta)

    quote do
      Kernel.def(unquote(name), unquote(body))
    end
  end
end
