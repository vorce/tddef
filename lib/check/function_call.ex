defmodule Tddef.Check.FunctionCall do
  @moduledoc """
  Check that the function defined by `def` is called in a test.

  This is used internally by Tddef.
  """

  def check!(
        caller,
        {:when, _,
         [
           {name, _, args},
           _
         ]},
        meta
      ) do
    check!(caller, {name, [], args}, meta)
  end

  def check!(caller, {fn_name, _, args}, meta) do
    arity = length(args)
    test_file = meta |> Keyword.fetch!(:test_files) |> hd()

    with {:ok, contents} <- File.read(test_file),
         {:ok, ast} <- Code.string_to_quoted(contents, file: test_file),
         true <- function_called_in_ast?(ast, caller.module, fn_name, arity) do
      :ok
    else
      _ ->
        raise(
          "Can't find a function call of #{caller.module}.#{fn_name}/#{arity} in #{test_file}.\nCreate a test for the function in the test file."
        )
    end
  end

  @doc """
  Tries to determine if a particular `fn_name` with `arity`
  is called in the `ast`
  """
  def function_called_in_ast?(ast, module_name, fn_name, arity) do
    ast
    |> find(module_name, fn_name, arity)
    |> Enum.any?(&(&1 == true))
  end

  # The AST uses a tuple to represent the basic building building block, the AST node.
  # An AST node always has the following format:
  # {marker, metadata, children}
  # The marker is some kind of atom,
  # the metadata is a keyword list which contains annotations about the metadata node (line number, file, optional column number, et cetera).
  # The children is either a list of child AST nodes or it’s an atom.
  defp find({fun, _metadata, args}, _module_name, fn_name, arity) when fun == fn_name do
    [length(args) == arity]
  end

  defp find(
         {{:., _, [{:__aliases__, _, modules}, fun]}, _, args},
         module_name,
         fn_name,
         arity
       )
       when fun == fn_name and is_list(modules) do
    last_expected_module = Module.split(module_name) |> Enum.reverse() |> hd() |> String.to_atom()

    matching_module? =
      modules
      |> Enum.reverse()
      |> hd()
      |> Kernel.==(last_expected_module)

    actual_arity = length(args)

    [matching_module? and actual_arity == arity]
  end

  defp find({_marker, _metadata, children}, module_name, fn_name, arity) when is_list(children) do
    children
    |> Enum.flat_map(fn child_ast -> find(child_ast, module_name, fn_name, arity) end)
  end

  defp find(ast, module_name, fn_name, arity) when is_list(ast) do
    Enum.flat_map(ast, fn sub_ast -> find(sub_ast, module_name, fn_name, arity) end)
  end

  defp find({_marker, ast}, module_name, fn_name, arity) do
    find(ast, module_name, fn_name, arity)
  end

  defp find(_, _module_name, _fn_name, _arity), do: []
end
