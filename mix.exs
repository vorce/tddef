defmodule Tddef.MixProject do
  use Mix.Project

  def project do
    [
      app: :tddef,
      version: "0.1.0",
      elixir: "~> 1.9",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      description: description(),
      package: package()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:ex_doc, "~> 0.21", only: :dev, runtime: false}
    ]
  end

  defp description() do
    "tddef helps you do test driven development in Elixir"
  end

  defp package() do
    [
      maintainers: ["joel@vorce.se"],
      licenses: ["LGPL-3.0"],
      links: %{"GitHub" => "https://github.com/vorce/tddef"}
    ]
  end
end
