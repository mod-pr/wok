defmodule Wok.Mixfile do
  use Mix.Project

  def project do
    [ app: :wok,
      version: "0.0.1",
      deps: deps ]
  end

  # Configuration for the OTP application
  def application do
    []
  end

  def deps do 
    [
      {:httpotion,"0.1.0",[github: "myfreeweb/httpotion"]} ,
      {:jsx,"1.3.3", [github: "talentdeficit/jsx", tag: "v1.3.3"]} 
    ]
  end
end
