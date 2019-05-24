include("lagpoly.jl")

n = 10
x = range(0, step=1/100, length=101)
X = range(0, step=1/n, length=n+1)
plot();
for k in eachindex(X)
    # k == 4 || continue
    plot!(x, lag_basis.(k,Ref(X),x));
end
scatter!(X,zero(X))
