defmodule Tddef.Check.FunctionCallTest do
  use ExUnit.Case

  alias Tddef.Check.FunctionCall

  describe "function_called_in_ast?/4" do
    test "returns nil when function cannot be found" do
      ast = {:__block__, [], []}

      assert FunctionCall.function_called_in_ast?(ast, Tddef.Use, :greet, 1) == false
    end

    test "returns true when function can be found" do
      ast =
        {:defmodule, [line: 1],
         [
           {:__aliases__, [line: 1], [:Tddef, :UseTest]},
           [
             do:
               {:__block__, [],
                [
                  {:use, [line: 2], [{:__aliases__, [line: 2], [:ExUnit, :Case]}]},
                  {:alias, [line: 4], [{:__aliases__, [line: 4], [:Tddef, :Use]}]},
                  {:describe, [line: 6],
                   [
                     "greet/1",
                     [
                       do:
                         {:test, [line: 7],
                          [
                            "returns string with name",
                            [
                              do:
                                {:assert, [line: 8],
                                 [
                                   {:==, [line: 8],
                                    [
                                      {{:., [line: 8],
                                        [{:__aliases__, [line: 8], [:Use]}, :greet]}, [line: 8],
                                       ["tdd"]},
                                      "Hello tdd"
                                    ]}
                                 ]}
                            ]
                          ]}
                     ]
                   ]}
                ]}
           ]
         ]}

      assert FunctionCall.function_called_in_ast?(ast, Tddef.Use, :greet, 1) == true
    end
  end
end
