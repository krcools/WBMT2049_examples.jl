using Plots

f(x) = (x < 0) ? (x-x^3) : sin(x)
f1(x) = (x < 0) ? (1-3*x^2) : cos(x)
f2(x) = (x < 0) ? -6^x : -sin(x)
f3(x) = (x < 0) ? -6 : -cos(x)

plot(range(-2,2,length=200), [f, f1, f2, f3])

Q(h,f,x) = (f(x+h)-f(x-h))/(2h)

df_exact = f1(0)

x = 0.0
h = [0.01, 0.02, 0.04]
df_approx = Q.(h,f,x)

p = log2((df_approx[3]-df_approx[2])/(df_approx[2]-df_approx[1]))
C = - (df_approx[2]-df_approx[1]) / (h[1]^p * (2^p-1))

Q_extra(h,f,x) = Q(h,f,x) + C*h^p
df_extra = Q_extra.(h,f,x)
