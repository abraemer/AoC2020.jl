module Day7
export day7

function parseLine(line)
    m = match(r"^([\w\s]*) bags contain ([\w\s,]*)\.$", line)
    if occursin("no other bags", m[2])
        return m[1], ()
    end
    m[1], map(split(m[2], ',')) do s
        let matches = match(r"(\d*) ([a-z\s]*) bags?", strip(s))
            parse(Int, matches[1]), matches[2]
        end
    end
end

function readInput(inputfile="inputs/input07.txt")
    data = Dict{String, Any}()
    for line in eachline(inputfile)
        newBag, contains = parseLine(line)
        data[newBag] = contains
    end
    data
end

function day7(inputfile="inputs/input07.txt")
    data = readInput(inputfile)
    (day7Part1(data), day7Part2(data))
end

function day7Part1(data)
    ## invert relationship data[bag] -> contains
    ## need map bag -> contained in
    containedIn = Dict{String, Any}()
    for (bag, contains) in data
        for (amount, containedBag) in contains
            if haskey(containedIn, containedBag)
                push!(containedIn[containedBag], bag)
            else
                containedIn[containedBag] = [bag]
            end 
        end
    end
    
    ## find all connected nodes with "shiny gold"
    found = Set{String}()
    todo = containedIn["shiny gold"]
    while length(todo) > 0
        current = pop!(todo)
        if !(current in found) # have we looked at current already?
            push!(found, current)
            if haskey(containedIn, current) # current might be a root
                append!(todo, containedIn[current])
            end
        end
    end
    length(found)

end

function day7Part2(data)
    countBagsContained(data, "shiny gold")
end

## Little benchmark showed: memoization offers in fact NO speedup :(
countBagsContained(data, bag) = countBagsContained(data, bag, Dict{String, Int}())
function countBagsContained(data, bag, alreadyComputed)
    if !haskey(alreadyComputed, bag)
        amountContained = 0
        for (amount, subBag) in get(data, bag, ())
            amountContained += amount * (1 + countBagsContained(data, subBag, alreadyComputed))
        end
        alreadyComputed[bag] = amountContained
    end
    alreadyComputed[bag]
end


end #module