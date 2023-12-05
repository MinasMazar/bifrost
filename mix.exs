defmodule Bifrost.MixProject do
  use Mix.Project

  def project do
    [
      app: :bifrost,
      version: "0.1.0",
      elixir: "~> 1.14",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {Bifrost.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:plug_cowboy, "~> 2.0"},
      {:plug_socket, "~> 0.1"},
      {:jason, "~> 1.4"},
    ]
  end
end
