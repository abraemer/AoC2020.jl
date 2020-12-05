module Day5
export day5

function parseLine(line)
    for r in ("F"=>"0", "B"=>"1", "L"=>"0", "R"=>"1")
        line = replace(line, r)
    end
    parse(Int, line; base = 2)
end

function readInput(inputfile="inputs/input05.txt")
    [parseLine(line) for line in eachline(inputfile)]
end

function day5(inputfile="inputs/input05.txt")
    values = readInput(inputfile)
    (maximum(values), day5Part2(values))
end

function day5Part2(values)
    sort!(values)
    for (a,b) in zip(values, @view values[2:end])
        if b-a == 2
            return a+1
        end
    end
end

end #module