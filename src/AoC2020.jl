module AoC2020

include("day01.jl")
include("day02.jl")
include("day03.jl")
include("day04.jl")

# run all
function runalldays()
    display(Day1.day1())
    display(Day2.day2())
    display(Day3.day3())
    display(Day4.day4())
end

end
