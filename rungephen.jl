include("lagpol.jl")

using Plots

f(x) = 1 / (1+x^2)
n = 14
X = range(-5, step=10/n, length=n+1)
Y = f.(X)
L = lag_interpolant(X,Y)

using Plots
T = range(-5, step=10/200, length=201)
plot();
plot!(T,f.(T));
plot!(T,L.(T));
scatter!(X,zero(X),ylims=(-1,8))

K = 0:n
Xch = 5*cos.((2K.+1)/2/(n+1)*π)
Ych = f.(Xch)
Lch = lag_interpolant(Xch,Ych)

plot();
plot!(T,f.(T));
plot!(T,Lch.(T));
scatter!(Xch,zero(Xch),ylims=(-1,+1))

plot!()
