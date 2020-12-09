module AoC2020 

# include("util.jl")
include("console.jl")

for day in 1:9
    if day < 10
        include("day0$day.jl")
    else
        include("day$(day).jl")
    end
end

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
end

end
