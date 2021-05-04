using Plots

p(t) = 20
f(t,y) = -10*y^2 + p(t)
t0, y0 = 0.0, 0.0


tmax, Δt = 1, 0.06
t = [t0]
w = [y0]
while last(t) < tmax
    t_old, w_old = last(t), last(w)
    t_new = t_old + Δt
    w_new = w_old + Δt * f(t_old,w_old)

    push!(w,w_new)
    push!(t,t_new)
end

y = √2 * tanh.(√300 * t)
plot()
plot!(t,y,c=:red)
scatter!(t,w,m=:o,c=:blue)