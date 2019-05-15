include("lagpol.jl")
using Plots

plot();
for n in 1:5
    X = range(0, step=1/n, length=n+1)
    T = range(0, step=1/200, length=201)
    Y = zero(T)
    for k in eachindex(X)
        Y .+= abs.(lag_basis.(k,Ref(X),T))
    end
    @show maximum(Y)
    plot!(T,Y)
end

plot!()


plot();
for n in 1:5
    K = 0:n
    X = 0.5.+0.5*cos.((2K.+1)/2/(n+1)*π)
    T = range(0, step=1/200, length=201)
    Y = zero(T)
    for k in eachindex(X)
        Y .+= abs.(lag_basis.(k,Ref(X),T))
    end
    @show maximum(Y)
    plot!(T,Y)
end

plot!()
