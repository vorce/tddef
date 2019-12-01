defmodule Kex.Use do
  use Kex

  def greet(name) when is_binary(name) do
    "Hello " <> name
  end
end
