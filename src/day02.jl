module Day2
export day2

function parseInput(inputfile="inputs/input02.txt")
    input = Any[]
    for line in eachline(inputfile)
        #if line == "" break end
        range_raw, letter_raw, password = split(line, ' ')
        range = let (min,max) = split(range_raw, '-')
            parse(Int, min):parse(Int, max)
        end
        letter = letter_raw[1]
        push!(input, (range, letter, password))
    end
    input
end

function day2(inputfile="inputs/input02.txt")
    parsedInput = parseInput(inputfile)
    (count(isValidPWD, parsedInput), count(isValidPWDPart2, parsedInput))
end

isValidPWD(data) = isValidPWD(data...)
function isValidPWD(range, letter, password)
    count(c->(c==letter), password) ∈ range
end

isValidPWDPart2(data) = isValidPWDPart2(data...)
function isValidPWDPart2(range, letter, password)
    xor(letter==password[range.start], letter==password[range.stop])
end

end #module