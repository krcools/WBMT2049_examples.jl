using Plots

include("methods.jl")

f(t,(y1,y2)) = [y1*(1-y1-y2), y2*(1/2-3/4*y1-1/4*y2)]

t0, T = 0.0, 80.0
# y0 = [3/4, 1/4] # Like in the book
y0 = [1/2, 1/2] + 1e-3*(rand(2).-1/2) # start from equilibrium
ts,ws = forward_euler(f, t0, y0, 1.0, T)

ws1 = getindex.(ws,1)
ws2 = getindex.(ws,2)
plot(ts, ws1, ylims=(0,2))
plot!(ts, ws2)
