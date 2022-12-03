open(ARGS[1], "r") do input
    score1 = 0
    score2 = 0
    for line in eachline(input)
        opponent, mine = line[1], line[3]
        score1 += mine - 'W'
        score1 += 3 * (mod((mine-23) - opponent,-1:1)+1)
        score2 += mod((opponent- 'A' + 1) + (mine-'Y'), 1:3)
        score2 += 3 * (mod(mine-'Y', -1:1) + 1)
    end
    score1, score2
end |> println
