#!elixir
# Say hello
# The module Greeter is redefined each time it compiles
# but that is alright, because the code does change.
# This does make code organization cleaner though you could
# argue whether you need it as much.

defmodule Greeter do
    def hello(name) do
        "Hello, " <> name
    end
end

fn (name) ->
    Greeter.hello(name)
end

