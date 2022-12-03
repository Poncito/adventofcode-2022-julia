function char2int(x::Char)
    y = x-'a'+1
    y < 0 ? x-'A'+27 : y
end

function buildset(rucksack)
    set = Int64(0)
    for char in rucksack
        set |= Int64(1)<<char2int(char)
    end
    set
end

function findelement(x, ::Val{a}, ::Val{b}) where {a,b}
    if a == b
        return a
    else
        c = (a+b) >> 1
        x > (1 << c) ? findelement(x, Val(c+1), Val(b)) : findelement(x, Val(a), Val(c))
    end
end
findelement(x) = findelement(x, Val(1), Val(52))

function findduplicate(sack)
    n = length(sack)
    nhalf = n >> 1
    set = buildset(view(sack,1:nhalf))
    for char in view(sack,nhalf+1:n)
        i = char2int(char)
        set >> i & 1 == 1 && return i
    end
end

open(ARGS[1], "r") do input
    priority_sum = 0
    badge_sum = 0
    for (sack1, sack2, sack3) in Iterators.partition(eachline(input), 3)
        priority_sum += findduplicate(sack1) + findduplicate(sack2) + findduplicate(sack3)
        badge_sum += findelement(buildset(sack1) & buildset(sack2) & buildset(sack3))
    end
    priority_sum, badge_sum
end |> println