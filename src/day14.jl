module Day14
export day14

function parseMask(mask)
    fixed = 0
    variable = 0
    for (power, index) in enumerate(reverse(1:length(mask)))
        char = mask[index]
        if char == 'X'
            variable += 1 << (power-1)
        elseif char == '1'
            fixed += 1 << (power-1)
        end
    end
    :mask, fixed, variable
end

function parseLine(line)
    mask = match(r"^mask = ([X01]{36})$", line)
    if mask !== nothing
        return parseMask(mask[1])
    end

    mem = match(r"^mem\[(\d*)\] = (\d*)$", line)
    if mem !== nothing
        return (:mem, parse(Int, mem[1]), parse(Int, mem[2]))
    end
    error("Strange line: ", line)
end

"Parse input to a list of lines.
Possible types:
 - :mem, adress, value
 - :mask, fixedbits, variablebits"
function readInput(inputfile="inputs/input14.txt")
    [parseLine(line) for line in eachline(inputfile)]
end

function day14(inputfile="inputs/input14.txt")
    values = readInput(inputfile)
    (day14Part1(values), day14Part2(values))
end

function day14Part1(input)
    currentFixed = 0
    currentVariable = 0
    memory = Dict{Int, Int}()
    for (type, p1, p2) in input
        if type === :mask
            currentFixed = p1
            currentVariable = p2
        elseif type === :mem
            memory[p1] = (currentFixed + (currentVariable & p2))
        end
    end
    sum(values(memory))
end

function computeFluctuations(value)
    power = 0
    non_zeros = []
    while value > 0
        value, r = divrem(value, 2)
        if r == 1
            push!(non_zeros, 0:2^power:2^power)
        end
        power += 1
    end
    vec(map(sum, Iterators.product(non_zeros...)))
end

function day14Part2(input)
    # use fixed Mask with OR (|) now -> 0 no change -> 1 overwritten
    currentFixed = 0
    currentVariable = [0]
    memory = Dict{Int, Int}()
    for (type, p1, p2) in input
        if type === :mask
            currentFixed = p1
            currentVariable = computeFluctuations(p2)
        elseif type === :mem
            for addr in currentVariable .+ (p1 | currentFixed)
                memory[addr] = p2
            end
        end
    end
    sum(values(memory))
end

end #module