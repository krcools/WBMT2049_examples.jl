function forward_euler(f,t0,y0,Δt,T)
    t, ws = t0, [y0]
    while t < T
        wold = last(ws)
        wnew = wold + Δt*f(t,wold)
        push!(ws, wnew)
        t += Δt
    end
    return range(t0, step=Δt, length=length(ws)), ws
end

function modified_euler(f,t0,y0,Δt,T)
    t, ws = t0, [y0]
    while t < T
        wold = last(ws)
        fold = f(t,wold)
        znew = wold + Δt*fold
        wnew = wold + Δt/2*(fold+f(t+Δt,znew))
        push!(ws, wnew)
        t += Δt
    end
    return range(t0, step=Δt, length=length(ws)), ws
end

function runge_kutta_4(f,t0,y0,Δt,T)
    t, ws = t0, [y0]
    while t < T
        wn = last(ws)
        k1 = Δt * f(t,wn)
        k2 = Δt * f(t+Δt/2,wn+k1/2)
        k3 = Δt * f(t+Δt/2,wn+k2/2)
        k4 = Δt * f(t+Δt,wn+k3)
        push!(ws, wn + (k1+2k2+2k3+k4)/6)
        t += Δt
    end
    return range(t0, step=Δt, length=length(ws)), ws
end
