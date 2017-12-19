#!elixir
# Add two numbers and return the total
#
# An anonymous function is used above the final
# anonymous function which is the main function
# for this dynamic call.
# In order to use an anynymous function use the
# dot operator between the variable name and
# the parenthesis.
#
# Author: Neeraj Sharma <neeraj.sharma@alumni.iitg.ernet.in>
#

adder = fn (a, b) -> a + b end

fn (a, b) ->
    adder.(a, b)
end

