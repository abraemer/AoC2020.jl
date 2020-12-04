module DayNNN
export dayNNN

function readInput(inputfile="inputs/input0NNN.txt")
    lines = collect(eachline(inputfile))
    lines
end

function dayNNN(inputfile="inputs/input0NNN.txt")
    values = readInput(inputfile)
    (dayNNNPart1(values), dayNNNPart2(values))
end

function dayNNNPart1(values)
    
end

function dayNNNPart2(values)
    
end

end #module