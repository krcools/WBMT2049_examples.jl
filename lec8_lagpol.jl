using Plots

n = 10
X = range(-1,1,length=n+1)

g(x) = prod(x.-X)

plot(-1:0.01:1, g)