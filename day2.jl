#=
result:
    0 = defeat
    1 = draw
    2 = victory

hand:
    0 = rock
    1 = paper
    2 = scissors
=#
handvalue(x::Int) = x+1
resultvalue(r::Int) = 3*r
result(me::Int, opponent::Int) = mod(me-opponent, -1:1) + 1
hand(result::Int, opponent::Int) = mod(opponent+result-1, 3)
score(me::Int, result::Int) = handvalue(me) + resultvalue(result)

open(ARGS[1], "r") do input
    score1, score2 = 0, 0
    for line in eachline(input)
        opponent, me = line[1] - 'A', line[3]-'X'
        score1 += score(me, result(me, opponent))
        score2 += score(hand(me, opponent), me)
    end
    score1, score2
end |> println
