# Wok

** TODO: Add description **
defmodule Wok do
   
  @before_compile __MODULE__
  """
  def themes() do
      [
        "app", "au", "bi", "biz", 
        "bo", "br", "c", "em",
        "ew", "fa", "fiz", "fl", 
        "fs", "ftb", "gd", "hh",
        "hi", "hw", "me", "mg",
        "mlp", "mo", "mov", "mu",
        "ne", "pvc", "ph", "po", 
        "pr", "psy", "ra", "re", 
        "s", "sf", "sci", "sn",
        "sp", "spc", "t", "tr", 
        "tv", "un", "w", 
        "web",
        "wh", 
        "wm"
      ]
  end

  def creativity do
    [
      "di", "de", "diy", "dom", 
      "f", "izd", "mus", "o", 
      "pa", "p", "wp", "wrk", 
      "td" 
    ]
  end
  
  def games do
    [
      "bg", "cg", "gb", "mc", 
      "mmo", "tes", "vg", "wr" 
    ]
  end

  def japan do
    [
      "a", "aa", "fd", "ja", "ma", "rm", "to", "vn"
    ]
  end

  def other do
    [
      "d", "b", "soc", "gif", "r", "abu", "int"
    ]
  end

  def adult do
    [
      "fg", "fur", "g", "ga", 
      "h", "ho", "hc", "e", 
      "fet", "sex", "fag"
    ]
  end
  """
  def z do
    "123"
  end
    

 