using Plots

a = -1
f(t,y) = a*y
t0, y0 = 0.0, 1.0
tmax = 4.0

ts = [t0]
ws = [y0]
told = t0
dt = 0.01
while told <= tmax

    told = last(ts)
    wold = last(ws)

    tnew = told + dt
    wnew = wold + dt * f(told, wold)

    push!(ts, tnew)
    push!(ws, wnew)
end

y(t) = y0 * exp(a*(t-t0))
plot(ts,y.(ts))
scatter!(ts, ws)
