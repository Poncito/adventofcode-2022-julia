function _symmetric(A::AbstractArray{T,2}) where {T}
    m, n = size(A)
    view(A,1:m,n:-1:1)
end

function f_colfirst!(A, B)
    m, n = size(A)
    for i in 2:m-1
        x = 0
        for j in 2:n-1
            x = max(x, A[i,j-1]+1)
            B[i,j] = min(B[i,j], x)
        end
    end
end

function f2_colfirst!(A, B)
    m, n = size(A)
    k = Vector{Int}(undef, 10)
    for i in 2:m-1
        k .= 1
        for j in 2:n-1
            k[1+A[i,j-1]] = j-1
            B[i,j] *= j - maximum(k[1+A[i,j]:10])
        end
    end
end

open(ARGS[1], "r") do input
    A = mapreduce(line->parse.(Int, split(line, "")), hcat, readlines(input))
    B = copy(A); B[2:end-1,2:end-1] .= 10
    B2 = ones(Int, size(A))
    for f in (identity, _symmetric, transpose, _symmetric ∘ transpose)
        f_colfirst!(f(A), f(B))
        f2_colfirst!(f(A), f(B2))
    end
    sum(A .>= B), maximum(B2)
end |> println