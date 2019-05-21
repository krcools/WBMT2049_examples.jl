include("lagpol.jl")

f(x) = 1/x
X = [2, 2.5, 4]
Y = f.(X)

L = lag_interpolant(X,Y)
L(3)
