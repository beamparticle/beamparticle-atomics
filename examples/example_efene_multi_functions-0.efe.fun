#!efene
#_ "A sample efene code which shows that the last function block"
#_ "is converted to the function with zero arity and will in-turn"
#_ "invoke the previous anonymous functions like IsOdd, Increment, etc"
#_ ""
#_ "Author: Neeraj Sharma <neeraj.sharma@alumni.iitg.ernet.in>"

IsOdd     = fn case X: X % 2 is 0 end
Increment = fn case X: X + 1 end
MyMap     = fn case List, Fun: lists.map(Fun, List) end

fn
    case:
        lists.seq(1, 10) ->>
            lists.filter(IsOdd) ->
            MyMap(Increment)
end

