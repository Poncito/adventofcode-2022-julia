function f(line, n)
    x = zeros(Int, n - 1)
    for i = 2:length(line)
        for j = 1:min(n - 1, i - 1)
            x[j] = line[i] == line[i-j] ? 0 : x[j] + 1
        end
        all(x[i] >= n - i for i = 1:n-1) && return i
    end
end

open(ARGS[1], "r") do input
    line = readline(input)
    f(line, 4), f(line, 14)
end |> println

