using Plots

Q(h,f,x) = (f(x+h) - f(x-h))/(2*h)

f(x) = exp(x)
x = 1/2

df_exact = exp(1/2)

h = 2.0 .^ collect(0:-1:-53)
digits = log10.(h)
df_approx = Q.(h,f,x)

trunc_error = df_exact .- df_approx

plot(digits, log10.(abs.(trunc_error)))

ϵ = exp(1/2) * eps(1.0)
M = exp(1/2)
h_opt = (3*ϵ/M)^(1/3)
ϕ_opt = 0.5 * M^(1/3) * (3*ϵ)^(2/3)

vline!(log10.([h_opt]))
hline!(log10.([ϕ_opt]))