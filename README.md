# Wok

Wrap 2ch.hk api

## Installation

In mix.exs

```
{wok,".*",{git,"https://github.com/mod-pr/wok",{branch,"master"}}}
```

### Usage

```elixir
  pid = self
  a = spawn(Wok, :pr, [])
  a <- {pid, :pages} # get page count 
  a <- {pid, 0} # get threads from `wakaba` page
  a <- {pid, 111, :res} # posts from `111` thread

  receive do
    {:ok, resp} -> resp
    {:fail, why} -> why |> IO.puts
  end
```


## TODO

```
  $ grep -r "TODO"
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)

   

    

 