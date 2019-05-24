using Polynomials

struct Spline{T}
    X::Vector{T}
    A::Vector{T}
    B::Vector{T}
    C::Vector{T}
    D::Vector{T}
end

function (s::Spline)(x, k=0)
    i = findfirst(s.X .> x)
    i = (i == nothing) ? length(s.X) : i-1
    p = Poly([s.D[i],s.C[i],s.B[i],s.A[i]])
    return polyval(polyder(p,k),x-X[i])
end

function Spline(X,F)
    n = length(X)-1
    H = X[2:end] - X[1:end-1]
    D = F[1:end-1]
    Z = zeros(n-1,n-1)
    for i in 1:n-1
        Z[i,i] = 2*(H[i]+H[i+1])
    end
    for i in 1:n-2
        Z[i,i+1] = H[i]
        Z[i+1,i] = H[i]
    end
    r = zeros(n-1)
    for i in 1:n-1
        r[i] = 3*((F[i+2]-F[i+1])/H[i+1] - (F[i+1]-F[i])/H[i])
    end
    B = Z \ r
    B = vcat([0.0],B,[0.0])
    C = (F[2:end]-F[1:end-1])./H - H.*(2*B[1:end-1]+B[2:end])/3
    A = (B[2:end]-B[1:end-1])./(3*H)
    B = B[1:end-1]
    return Spline(X[1:end-1],A,B,C,D)
end

X = [-1.0, 0.0, +1.0]
X = [0.0, 1.0, 2.0]
f(x) = x^2
# F = [1.0, 0.0, 1.0]
F = f.(X)

s = Spline(X,F)
T = range(X[1],stop=X[end],length=201)

using Plots
plot(T,s.(T))
plot!(T,f.(T))
scatter!(X,F)

X = collect(range(-5,stop=+5,length=13))
f(x) = 1/(1+x^2)
F = f.(X)

s = Spline(X,F)
T = range(-5,stop=5,length=201)
plot(T,s.(T))
plot!(T,f.(T))
scatter!(X,F)
plot!(T,s.(T,1))
plot!(T,s.(T,2))
plot!(T,s.(T,3))
