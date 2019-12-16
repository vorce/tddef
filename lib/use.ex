defmodule Tddef.Use do
  use Tddef

  def greet(name) when is_binary(name) do
    "Hello " <> name
  end
end
