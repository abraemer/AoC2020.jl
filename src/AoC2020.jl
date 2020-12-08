module AoC2020

include("util.jl")

include("day01.jl")
include("day02.jl")
include("day03.jl")
include("day04.jl")
include("day05.jl")
include("day06.jl")
include("day07.jl")

# run all
function runalldays()
    display(Day1.day1())
    display(Day2.day2())
    display(Day3.day3())
    display(Day4.day4())
    display(Day5.day5())
    display(Day6.day6())
    display(Day7.day7())
end

end
