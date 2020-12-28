module Day13
export day13

function readInput(inputfile="inputs/input13.txt")
    lines = readlines(inputfile)
    (parse(Int, lines[1]), split(lines[2], ','))
end

function day13(inputfile="inputs/input13.txt")
    values = readInput(inputfile)
    (day13Part1(values), day13Part2(values[2]))
end

function day13Part1(values)
    timestamp, ids = values
    relevantIDs = map( filter(id -> id != "x", ids)) do id
        let id = parse(Int, id)
            (mod(-timestamp, id), id)
        end
    end
    *(sort!(relevantIDs; by=first)[1]...)
end

function extendedEuclid(a,b)
    r1, r2 = a > b ? (a, b) : (b, a)
    s1,t1, s2,t2 = (1,0,0,1)
    
    q, r3 = divrem(r1, r2)
    while r3 > 0
        r1, r2 = r2, r3
        s1, s2 = s2, s1-q*s2
        t1, t2 = t2, t1-q*t2
        q, r3 = divrem(r1, r2)
    end
    if a > b
        s2, t2, r2
    else
        t2, s2, r2
    end
end


function day13Part2(values)
    depatures = map(filter((indAndVal) -> indAndVal[2] != "x", collect(enumerate(values)))) do ((i, val))
        let id = parse(Int, val)
            (id-mod(i-1, id), id)
        end
    end
    multiplicator = 1 # lcm of all prior values -> multiplicator mod priorValue = 0
    val = 0 # current value fulfilling all prior congruency demands
    for (rem, divisor) in depatures
        # assume all divisors are coprime (which is true for my input)
        if gcd(multiplicator, divisor) != 1
            error("Not all divisors coprime!")
        end

        # solve for k: k*multiplicator + val = rem (mod divisor)
        # <=> k*multiplicator - l*divisor = rem - val
        k, l, r = extendedEuclid(multiplicator, divisor)
        if r != 1
            error("Not all divisors coprime!")
        end

        val += (rem-mod(val, divisor)) * k * multiplicator
        multiplicator *= divisor
        val = mod(val, multiplicator)
    end
    val
end

end #module