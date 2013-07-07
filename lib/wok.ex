defmodule Wok do
  #TODO 
  # timeout change
  # base url change

  #TODO 
  # list to tuple?

  Record.import Wok.Thread, as: :Thread
  Record.import Wok.Post, as: :Post

  @before_compile __MODULE__
  
  #
  # pid = self
  # f = spawn(Wok, :pr, [])
  # f <- 1
  # or
  # f <- :pages
  # f <- {1, :res}
  #
  # receive do
  #   {:ok, a} -> a 
  #   {:fail, why} -> why |> IO.puts 
  # end   
  # 
  
  defmacro base do
    "http://2ch.hk"
  end

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

  #TODO hidden boards

    
  #TODO response as Thread[Posts] or Post[attrs]
  defmacro __before_compile__(_env) do
    quote do
      Enum.map Wok.adult() ++ Wok.themes() ++ Wok.creativity() ++ Wok.games() ++ Wok.japan() ++ Wok.other(), fn(x) ->
        name   = binary_to_atom(x)
        args   = quote(do: [])
        guards = quote(do: [])
        exprs  = 1
        
        def name, args, guards, do: quote(do: 
          receive do
            #page count
            {pid, :pages} ->  
              process = :erlang.process_info(self)
              {_, cf, _} = process[:current_function]
              url = "#{Wok.base}/#{cf}/wakaba.json"


            #posts from thread
            {pid, thread, :res} when thread |> is_integer -> 
              process = :erlang.process_info(self)
              {_, cf, _} = process[:current_function]
              url = "#{Wok.base}/#{cf}/res/#{thread}.json"
              get(url) 

            #threads from page
            {pid, num} when num |> is_integer ->  
              if num == 0 do
                num = "wakaba"
              end

              process = :erlang.process_info(self)
              {_, cf, _} = process[:current_function]
              url = "#{Wok.base}/#{cf}/#{num}.json"  
              get(url)

            _ -> 
              pid <- {:fail, "bad args"}    
          end
        )
      end
    end
  end



  defp get(url) do
    IO.puts(url)
    HTTPotion.start
    resp = HTTPotion.get url
    
    if resp.status_code == 200 do
      :jsx.decode to_binary(resp.body)
    else
      [:fail, "status code: #{resp.status_code}"]  
    end 
  end 

end
