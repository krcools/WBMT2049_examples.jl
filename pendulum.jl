using Plots
include("methods.jl")

f(t,(θ,ω)) = [ω, -sin(θ)]
t0, y0, T = 0.0, [0.0, π/4], 100.0

Δt = 0.5
ts1, ws1 = modified_euler(f,t0,y0,Δt,T)
ts2, ws2 = runge_kutta_4(f,t0,y0,Δt,T)

plot()
plot!(ts1, getindex.(ws1,1))
plot!(ts2, getindex.(ws2,1))

Q_me(s) = 1 + s + 1/2*s^2
Q_rk(s) = 1 + s + 1/2*s^2 + 1/6*s^3 + 1/24*s^4

λ = 1.0im
abs(Q_me(λ*Δt))
abs(Q_rk(λ*Δt))
