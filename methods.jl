using NLsolve

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



function backward_euler(f,t0,y0,Δt,T)
    t, ws = t0, [y0]
    while t < T
        wn = last(ws)
        sol = nlsolve(x -> wn .+ Δt*f.(t+Δt, x) .- x, [wn])
        @assert sol.f_converged
        push!(ws, first(sol.zero))
        t += Δt
    end
    return range(t0, step=Δt, length=length(ws)), ws
end

function backward_euler(f,t0,y0::Vector,Δt,T)
    t, ws = t0, [y0]
    while t < T
        wn = last(ws)
        sol = nlsolve(x -> wn + Δt*f(t+Δt, x) - x, wn)
        @assert sol.f_converged
        push!(ws, sol.zero)
        t += Δt
    end
    return range(t0, step=Δt, length=length(ws)), ws
end

function trapezoid_rule(f,t0,y0,Δt,T)
    t, ws = t0, [y0]
    while t < T
        wn = last(ws)
        sol = nlsolve(x -> wn .+ Δt/2*(f.(t,wn) .+ f.(t+Δt, x)) .- x, [wn])
        @assert sol.f_converged
        push!(ws, first(sol.zero))
        t += Δt
    end
    return range(t0, step=Δt, length=length(ws)), ws
end

function trapezoid_rule(f,t0,y0::Vector,Δt,T)
    t, ws = t0, [y0]
    while t < T
        wn = last(ws)
        sol = nlsolve(x -> wn + Δt/2*(f(t,wn) + f(t+Δt, x)) - x, wn)
        @assert sol.f_converged
        push!(ws, sol.zero)
        t += Δt
    end
    return range(t0, step=Δt, length=length(ws)), ws
end


# ts1, ws1 = backward_euler((t,y)->-y, 0.0, 1.0, 0.01, 2.0)
# ts2, ws2 = trapezoid_rule((t,y)->-y, 0.0, 1.0, 0.01, 2.0)
# ws0 = exp.(-ts1)
