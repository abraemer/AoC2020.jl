module Day4
export day4

function parseLine(line)
    if line == "" return nothing end
    Dict(map(p->Pair(split(p, ':'; limit=2)...), split(line, ' ')))
end

function readInput(inputfile="inputs/input04.txt")
    parsed = [parseLine(l) for l in eachline(inputfile)]

    data = Any[]
    current = Dict{String, String}()
    for p in parsed
        if p === nothing && length(current) > 0
            push!(data, current)
            current = Dict{String, String}()
            continue
        end
        current = merge(current, p)
    end
    if length(current) > 0
        push!(data, current)
    end
    data
end

function day4(inputfile="inputs/input04.txt")
    values = readInput(inputfile)
    validPart1 = filter(day4Part1, values)
    (length(validPart1), count(day4Part2, validPart1))
end

function day4Part1(fields)
    (length(fields) == 8) || (length(fields) == 7 && !haskey(fields, "cid"))
end

function day4Part2(values)
    validateBYR(values["byr"]) &&
    validateIYR(values["iyr"]) &&
    validateEYR(values["eyr"]) &&
    validateHGT(values["hgt"]) && 
    validateHCL(values["hcl"]) && 
    validateECL(values["ecl"]) && 
    validatePID(values["pid"])
end

inRange(v, lower, upper) = lower <= parse(Int, v) <= upper

validateBYR(v) = occursin(r"^\d{4}$", v) && inRange(v, 1920, 2002)
validateIYR(v) = occursin(r"^\d{4}$", v) && inRange(v, 2010, 2020)
validateEYR(v) = occursin(r"^\d{4}$", v) && inRange(v, 2020, 2030)
function validateHGT(v)
    m = match(r"^(\d+)(in|cm)$", v)
    if m === nothing return false end
    num, unit = m.captures
    if unit == "cm"
        inRange(num, 150, 196)
    elseif unit == "in"
        inRange(num, 59, 76)
    else
        false
    end
end
validateHCL(v) = occursin(r"^#[0-9a-f]{6}$", v)
validateECL(v) = v in ("amb", "blu", "brn", "gry", "grn", "hzl", "oth")
validatePID(v) = occursin(r"^[0-9]{9}$", v)

end #module