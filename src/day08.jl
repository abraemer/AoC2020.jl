module Day8
export day8

import ..Console

function readInput(inputfile="inputs/input08.txt")
    Console.parseInstructions(eachline(inputfile))
end

function day8(inputfile="inputs/input08.txt")
    instructions = readInput(inputfile)
    (day8Part1(instructions), day8Part2(instructions))
end

function day8Part1(instr)
    gotoLoop!(Console.Program(instr)).acc
end

function gotoLoop!(prog)
    instructionsRun = Set{Int}()
    while !(prog.ip in instructionsRun || Console.hasFinished(prog))
        push!(instructionsRun, prog.ip)
        Console.step!(prog)
    end
    prog
end

function day8Part2(instructions)
    for (i, instr) in enumerate(instructions)
        if instr.name == "nop"
            instructions[i] = Console.Instruction("jmp", instr.arg)
            prog = gotoLoop!(Console.Program(instructions))
            if Console.hasFinished(prog)
                return prog.acc
            end
            instructions[i] = instr
        elseif instr.name == "jmp"
            instructions[i] = Console.Instruction("nop", instr.arg)
            prog = gotoLoop!(Console.Program(instructions))
            if Console.hasFinished(prog)
                return prog.acc
            end
            instructions[i] = instr
        end
    end
end

end #module