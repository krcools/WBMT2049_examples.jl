using Plots

function forward_euler(f, t0, tmax, y0, Δt)
    t = [t0]
    w = [y0]
    while last(t) < tmax
        t_old, w_old = last(t), last(w)
        t_new = t_old + Δt
        w_new = w_old + Δt * f(t_old,w_old)
        
        push!(w,w_new)
        push!(t,t_new)
    end
    return t, w
end

f(t,y) = -10*y^2 + 20
t0, tmax, y0 = 0.0, 1.0, 0.0
t, w = forward_euler(f, t0, tmax, y0, 1/(10*sqrt(2)))

y = √2 * tanh.(√300 * t)
plot()
plot!(t,y,c=:red)
scatter!(t,w,m=:o,c=:blue)


f2(t,y) = 1 + (t-y)^2
t0, tmax, y0 = 2.0, 10.0, 1.0
t2, w2 = forward_euler(f2, t0, tmax, y0, 0.5)
y2(t) = t + 1 /(1-t)

plot()
plot!(t2,y2,c=:red)
scatter!(t2,w2,m=:o,c=:blue)