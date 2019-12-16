defmodule Tddef.UseTest do
  use ExUnit.Case

  alias Tddef.Use

  describe "greet/1" do
    test "returns string with name" do
      assert Use.greet("tdd") == "Hello tdd"
    end
  end
end
