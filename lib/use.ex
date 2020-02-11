defmodule Tddef.Use do
  @moduledoc false
  use Tddef

  def greet(name) when is_binary(name) do
    "Hello " <> name
  end
end
