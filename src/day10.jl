module Day10
export day10

function readInput(inputfile="inputs/input10.txt")
    vals = sort!([parse(Int, line) for line in eachline(inputfile)])
    vcat([0], vals, maximum(vals)+3)
end

function day10(inputfile="inputs/input10.txt")
    values = readInput(inputfile)
    (day10Part1(values), day10Part2(values))
end

function day10Part1(values)
    diff1 = 0
    diff3 = 0
    for (a, b) in zip(values, values[2:end])
        if b-a == 1
            diff1 += 1
        elseif b-a == 3
            diff3 += 1
        end
        if b-a > 3
            print(a," - ", b)
        end
    end
    diff1 * diff3
end

function day10Part2(values)
    combinations = zeros(Int, size(values))
    combinations[end-2:end] .= 1 
    # the last adpater (n-1) can only connect directly to our device (n)
    # that means the second to last one (n-2) can only connect to the last (n-1)

    for index in reverse(1:length(combinations)-3)
        val = values[index]
        for δ in 1:3
            if values[index+δ] - val <= 3
                combinations[index] += combinations[index+δ]
            else
                break
            end
        end
    end
    combinations[1]
end

end #module