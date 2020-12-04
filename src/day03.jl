module Day3
export day3

function parseInput(inputfile="inputs/input03.txt")
    lines = collect(eachline(inputfile))
    data = BitArray{2}(undef, length(lines), length(lines[1]))
    for (i, line) in enumerate(lines)
        data[i,:] .= collect(line) .== '#'
    end
    data
end

function day3(inputfile="inputs/input03.txt")
    parsedInput = parseInput(inputfile)
    slopes = ((1,1), (3,1), (5,1), (7,1), (1,2))
    (countTrees(parsedInput, 3, 1), reduce(*, map(s->countTrees(parsedInput, s...), slopes)))
    #(count(isValidPWD, parsedInput), count(isValidPWDPart2, parsedInput))
end

function countTrees(data, right, down)
    trees = 0
    line = 1
    position = 0
    while line <= size(data, 1)
        if data[line, position+1]
            trees += 1
        end
        line += down
        position = mod(position+right, size(data, 2))
    end
    trees
end

end #module