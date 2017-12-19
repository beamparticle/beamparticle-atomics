#!elixir
# Add two numbers and return the total
#
# Author: Neeraj Sharma <neeraj.sharma@alumni.iitg.ernet.in>
#

fn (a, b) ->
    sum = &(&1 + &2)
    sum.(a,b)
end

