using DataStructures

struct Crates
    stacks::Vector{Deque{Char}}
end

Crates(n::Integer) = Crates([Deque{Char}() for _=1:n])

function move(crate::Crates, k, from, to)
    for  _ = 1:k
        c = popfirst!(crate[from])
        pushfirst!(crate[to], c)
    end
end

function move2(crate::Crates, k, from, to)
    c = popfirst!(crate[from])
    k > 1 && move2(crate::Crates, k-1, from, to)  
    pushfirst!(crate[to], c)
end

Base.length(c::Crates) = length(c.stacks)
Base.getindex(c::Crates, i) = c.stacks[i]

nstacks(line) = (length(line) + 1) ÷ 4
function parse_init_line(crates::Crates, line)
    for i=1:length(crates)
        c = line[4*i-2]
        c != ' ' && push!(crates[i], c)
    end
end

function parse_move_line(line)
    (parse(Int, x) for x in collect(split(line, ' '))[[2,4,6]])
end


open(ARGS[1], "r") do input
    lines = input |> eachline |> Base.Stateful

    n = nstacks(peek(lines))
    crates = Crates(n)
    crates2 = Crates(n)

    for line in lines
        line[2] == '1'  && break
        parse_init_line(crates, line)
        parse_init_line(crates2, line)
    end

    @assert lines |> popfirst! |> isempty

    for line in lines 
        k, from, to = parse_move_line(line)
        @info "line" k from to
        move(crates, k, from, to)
        move2(crates2, k, from, to)
    end
    
    join(first(crates[i]) for i=1:n), join(first(crates2[i]) for i=1:n)
end |> println