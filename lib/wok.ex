defmodule Wok do
  
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

  defmacro adult do
    [
      "fg", "fur", "g", "ga", 
      "h", "ho", "hc", "e", 
      "fet", "sex", "fag"
    ]
  end
  
    

  defmacro __before_compile__(_env) do
    quote do
      Enum.map Wok.adult(), fn(x) ->
        name   = binary_to_atom(x)
        args   = quote(do: [])
        guards = quote(do: [])
        exprs  = 1
        
        def name, args, guards, do: quote(do: 
          receive do
            #page count
            :pages ->  
              process = :erlang.process_info(self)
              {_, cf, _} = process[:current_function]
              url = "#{Wok.base}/#{cf}/wakaba.json"


            #posts from thread
            {thread, :res} when thread |> is_integer -> 
              process = :erlang.process_info(self)
              {_, cf, _} = process[:current_function]
              url = "#{Wok.base}/#{cf}/res/#{thread}.json"
              get(url) 

            #threads from page
            num when num |> is_integer ->  
              if num == 0 do
                num = "wakaba"
              end

              process = :erlang.process_info(self)
              {_, cf, _} = process[:current_function]
              url = "#{Wok.base}/#{cf}/#{num}.json"  
              get(url)  
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
