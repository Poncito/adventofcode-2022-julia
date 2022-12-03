struct MaxSet{T}
    set::Vector{T}
end

MaxSet{T}(capacity::Integer) where T = MaxSet(zeros(T, capacity))

function Base.push!(set::MaxSet{T}, x::T) where {T}
    if set.set[1] < x
        set.set[1] = x
        sort!(set.set)
    end
    set
end

set = open(ARGS[1], "r") do input
    maxcalories = MaxSet{Int}(3)
    calories = 0
    for line in eachline(input)
        if isempty(line)
            push!(maxcalories, calories)
            calories = 0        
        else
            calories += parse(Int, line)
        end
    end
    maxcalories.set
end
println(last(set))
println(sum(set))
