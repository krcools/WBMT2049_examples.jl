using Plots

include("methods.jl")

p = 0.01
P = 2π
f(t,y) = -(1/p) * (y - cos(2π/P*t)) - sin(2π/P*t)
t0, y0 = 0.0, 0.0
Δt, T = 0.2, 4.0

ts1, ws1 = backward_euler(f, t0, y0, Δt, T)
ts2, ws2 = trapezoid_rule(f, t0, y0, Δt, T)

plot()
plot!(ts1, ws1)
plot!(ts2, ws2)

Q_be(s) = 1 / (1-s)
Q_tr(s) = (1+0.5s) / (1-0.5s)

abs(Q_be(-1/p*Δt))
abs(Q_tr(-1/p*Δt))
