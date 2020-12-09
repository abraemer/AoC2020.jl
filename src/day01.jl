module Day1
export day1, doublePointerSearch

function readInput(inputfile="inputs/input01.txt")
    open(inputfile) do f
        lines = Int[];
        while (l=readline(f)) !== ""
            push!(lines, parse(Int, l))
        end
        sort!(lines)
    end
end

function doublePointerSearch(values, targetSum)
    front = 1
    back = length(values)
    sum = values[front] + values[back]
    while (sum !== targetSum) && (front < back)
        if sum < targetSum
            front += 1
        else
            back -= 1
        end
        sum = values[front] + values[back]
    end
    return (front, back) # caller has to handle the fail case where front == back
end

function day1(inputfile="inputs/input01.txt")
    values = readInput(inputfile)
    (day1Part1(values), day1Part2(values))
end

function day1Part1(values)
    front, back = doublePointerSearch(values, 2020)
    @assert front < back "No 2 terms sum to 2020!"
    values[front]*values[back]
end

function day1Part2(values)
    for index3 in length(values):-1:3
        index1, index2 = doublePointerSearch(view(values, 1:index3), 2020-values[index3])
        if index1 < index2 # search successful
            return values[index1]*values[index2]*values[index3]
        end
    end
    error("No triplet summing to 2020 found!")
end

end #module