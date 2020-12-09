module Day9
export day9
import ..Day1

function readInput(inputfile="inputs/input09.txt")
    [parse(Int, line) for line in eachline(inputfile)]
end

function day9(inputfile="inputs/input09.txt")
    values = readInput(inputfile)
    part1 = day9Part1(values)
    part2 = day9Part2(values, part1)
    (part1, part2)
end

function day9Part1(values)
    preamble = 25
    for (i, val) in enumerate(values[27:end])
        front,back = Day1.doublePointerSearch(sort(values[i:i+25]), val)
        if front == back # failure
            return val
        end
    end
end

function day9Part2(values, part1)
    lower = 1
    upper = 2
    s = values[lower]+values[upper]
    while s !== part1 && upper <= length(values)
        if s > part1
            lower += 1
        else
            upper += 1
        end
        s = sum(@view values[lower:upper])
    end
    if upper > length(values)
        error("[Day09 Part2]No contiguous range in input summing to $part1 found!")
    end
    return sum(extrema(@view values[lower:upper]))
end        

end #module