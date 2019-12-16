defmodule Kex.UseTest do
  use ExUnit.Case

  alias Kex.Use

  describe "greet/1" do
    test "returns string with name" do
      assert Kex.Use.greet("tdd") == "Hello tdd"
    end
  end
end
