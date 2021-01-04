module AoC2020 

# include("util.jl")
include("console.jl")

for day in 1:10
    if day < 10
        include("day0$day.jl")
    else
        include("day$(day).jl")
    end
end

include("day12.jl")
include("day13.jl")
include("day14.jl")

# run all
function runalldays()
    display(Day1.day1())
    display(Day2.day2())
    display(Day3.day3())
    display(Day4.day4())
    display(Day5.day5())
    display(Day6.day6())
    display(Day7.day7())
    display(Day8.day8())
    display(Day9.day9())
    display(Day10.day10())
    # display(Day11.day11())
    display(Day12.day12())
    display(Day13.day13())
    display(Day13.day14())
end

end
