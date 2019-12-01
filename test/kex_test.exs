defmodule KexTest do
  use ExUnit.Case
  doctest Kex

  test "greets the world" do
    assert Kex.hello() == :world
  end
end
