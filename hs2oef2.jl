include("lagpol.jl")

X = [2, 2.5, 4]
f(x) = 1/x
Y = f.(X)

L = lag_interpolant(X,Y)
L(3)
