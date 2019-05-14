using Plots
using LinearAlgebra
include("methods.jl")

U = [1 -1; 1 1]/sqrt(2)
A = U * Diagonal([-1, -10_000]) * U'
f(t,(y1,y2)) = A*[y1,y2]

t0, y0 = 0.0, [1.0, 0.0]
Δt, T = 0.01, 2.0
ts1, ws1 = backward_euler(f,t0,y0,Δt,T)
ts2, ws2 = trapezoid_rule(f,t0,y0,Δt,T)

plot()
plot!(ts1, getindex.(ws1,1))
plot!(ts2, getindex.(ws2,1))
