module Day6
export day6


function readInput(inputfile="inputs/input06.txt")
    data = Any[]

    current = Any[]
    for line in eachline(inputfile)
        if line == "" && length(current) > 0
            push!(data, current)
            current = Any[]
        else
            push!(current, Set(line))
        end
    end
    if length(current) > 0
        push!(data, current)
    end
    data
end

function day6(inputfile="inputs/input06.txt")
    values = readInput(inputfile)
    (reduce(+, map(v -> length(union(v...)), values)), 
     reduce(+, map(v -> length(intersect(v...)), values)))
end

end #module