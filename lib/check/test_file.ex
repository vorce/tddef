defmodule Tddef.Check.TestFile do
  @moduledoc """
  Checks that the file that a `Tddef.def` definition is in also
  has a corresponding test file in the project.

  This is used internally by Tddef.
  """

  def check!(caller, _name) do
    caller_file_path = Macro.Env.location(caller)[:file]
    test_dir = Path.join(File.cwd!(), "test")
    test_file = test_file_of(caller_file_path)
    test_file_paths = find_test_file_of(test_dir, test_file)

    if(
      test_file_paths == [],
      do:
        raise(
          "Can't find test file for #{caller_file_path}\nCreate a file called #{test_file} somewhere in the test directory"
        )
    )

    {:ok, [test_files: test_file_paths]}
  end

  def test_file_of(caller_file_path) do
    caller_file = Path.basename(caller_file_path)
    [name, _suffix] = String.split(caller_file, ".")
    "#{name}_test.exs"
  end

  defp find_test_file_of(root_dir, test_file) do
    with {:ok, paths} <- File.ls(root_dir) do
      found_path = Enum.find(paths, fn path -> Path.basename(path) == test_file end)

      if found_path do
        [Path.join(root_dir, found_path)]
      else
        paths
        |> Enum.map(&Path.join(root_dir, &1))
        |> Enum.filter(&File.dir?/1)
        |> Enum.flat_map(&find_test_file_of(&1, test_file))
      end
    end
  end
end
