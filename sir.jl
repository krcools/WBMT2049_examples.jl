using Plots

function rk4(f,t0,tmax,y0,dt)

    ts = [t0]
    ws = [y0]
    while last(ts) <= tmax
        t = last(ts)
        w = last(ws)

        k1 = dt*f(t,w)
        k2 = dt*f(t+0.5*dt, w+0.5*k1)
        k3 = dt*f(t+0.5*dt, w+0.5*k2)
        k4 = dt*f(t+dt, w + k3)

        tnew = t + dt
        wnew = w + (k1+2*k2+2*k3+k4)/6

        push!(ts, tnew)
        push!(ws, wnew)
    end

    return ts, ws
end

const r = 2.5
# const r = 1.08
const p = 7.0
function sir(t,y)

    s = y[1]
    i = y[2]

    ds = -r/p*i*s
    di = +r/p*i*s - i/p

    return [ds, di]
end

t0, tmax = 0.0, 3*365.0, 0.1
y0 = [0.999, 0.001]
ts, ws = rk4(sir, t0, tmax, y0, 1.0)

plot()
plot!(ts, getindex.(ws,1))
plot!(ts, getindex.(ws,2))

i_max, idx = findmax(getindex.(ws,2))
ic_max = i_max * 0.02 * 20e6
deaths = 0.01*(1-getindex.(ws,1)[end]) * 20e6