module Util

struct Tree{V}
    id::Int
    value::V
    children::Vector{Tree{V}}
end

function findNode(value, currentNode)
    if value == currentNode.values
        return currentNode
    else
        for child in currrentNode.children
            result = findNode(value, child)
            if !(result === nothing) 
                return result
            end
        end
    end
    nothing
end

end #module