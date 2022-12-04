function parseline(line)
    r1, r2 = split(line, ',')
    start1, end1 = split(r1, '-')
    start2, end2 = split(r2, '-')
    r1 = parse(Int, start1):parse(Int, end1)
    r2 = parse(Int, start2):parse(Int, end2)
    r1, r2
end

includes(r1, r2) = (first(r1) <= first(r2)) && (last(r1) >= last(r2))
overlaps(r1, r2) = (last(r1) >= first(r2) && (last(r2) >= first(r1)))

open(ARGS[1], "r") do input
    nincludes, noverlaps = 0, 0
    for line in eachline(input)
        range1, range2 = parseline(line)
        (includes(range1, range2) || includes(range2, range1)) && (nincludes += 1)
        overlaps(range1, range2) && (noverlaps += 1)
    end
    nincludes, noverlaps
end |> println
