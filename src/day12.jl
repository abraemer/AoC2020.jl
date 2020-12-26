module Day12
export day12

parseAngle(arg) = div(arg, 90)

# char => (:name, factor, parsefunction)
const COMMANDS = Dict('R' => (:rotate, -1, parseAngle),
                      'L' => (:rotate,  1, parseAngle),
                      'F' => (:forward, 1, identity),
                      'N' => (:go, im, identity),
                      'S' => (:go, -im, identity),
                      'W' => (:go, -1, identity),
                      'E' => (:go, 1, identity))

function parseLine(line)
    command = line[1]    
    arg = parse(Int, line[2:end])
    name, factor, func = COMMANDS[command]
    name, factor*func(arg)
end

function readInput(inputfile="inputs/input12.txt")
    [parseLine(line) for line in eachline(inputfile)]
end

function day12(inputfile="inputs/input12.txt")
    instructions = readInput(inputfile)
    (day12Part1(instructions), day12Part2(instructions))
end

function day12Part1(instructions)
    at = complex(0)
    facing = complex(1)
    for (command, value) in instructions
        if command === :go
            at += value
        elseif command === :rotate
            facing *= (sign(value)*im)^abs(value)
        elseif command === :forward
            at += facing*value
        else
            error("Unknown instruction: $command")
        end
    end
    abs(real(at)) + abs(imag(at))
end

function day12Part2(instructions)
    waypoint = 10+1im
    at = complex(0)
    for (command, value) in instructions
        if command === :go
            waypoint += value
        elseif command === :rotate
            waypoint *= (sign(value)*im)^abs(value)
        elseif command === :forward
            at += waypoint*value
        else
            error("Unknown instruction: $command")
        end
    end
    abs(real(at)) + abs(imag(at))
end

end #module