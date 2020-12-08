module Console
export Instruction, parseInstructions, Program, step!, hasFinished

struct Instruction
    name::String
    arg::Int
end

Instruction(data::AbstractArray{<: AbstractString}) = Instruction(data[1], parse(Int, data[2]))

function parseInstructions(iter)
    [Instruction(split(line,' ')) for line in iter]
end

mutable struct Program
    instructions::Vector{Instruction}
    ip::Int
    acc::Int
end

Program(instructions::Vector{Instruction}) = Program(instructions, 1, 0)

Base.copy(prog::Program) = Program(prog.instructions, prog.ip, prog.acc)

hasFinished(prog::Program) = !(1 <= prog.ip <= length(prog.instructions))

function step!(prog::Program)
    if hasFinished(prog)
        return false
    end
    instruction = prog.instructions[prog.ip]
    if instruction.name == "nop"
        prog.ip += 1
    elseif instruction.name == "acc"
        prog.acc += instruction.arg
        prog.ip += 1
    elseif instruction.name == "jmp"
        prog.ip += instruction.arg
    else
        error("What is this instruction: $(instruction.name) ???")
    end
    return true
end

end #module