using Plots

function bisection(f,a,b,tol=sqrt(eps((a+b/2))))
    @assert f(a) * f(b) < 0
    an = copy(a)
    bn = copy(b)
    pn = (an+bn)/2
    P = [pn]
    while (bn-an) > 2*tol
        global number_of_iterations += 1
        if f(pn) * f(an) < 0
            bn = pn
        else
            an = pn
        end
        pn = (an+bn)/2
        push!(P,pn)
    end
    pn, P
end

function picard(g,p0,tol=sqrt(eps(p0)))
    p = copy(p0)
    P = [p]
    for i in 1 : 200
        global number_of_iterations += 1
        pnew = g(p)
        abs(pnew-p) < tol && break
        p = pnew
        push!(P,p)
    end
    p, P
end


f(x) = x^2-2
c = -0.5
g(x) = c*f(x)+x
h(x) = 2*c*x+1
a, b = 1.0, 2.0
p0 = 1.5
number_of_iterations = 0
p, P = picard(g,p0)
@show number_of_iterations

plot()
plot!(a:0.01:b,g)
plot!([a,b],[a,b],color=:black)
for i in 1:length(P)-1
    plot!([P[i],P[i],P[i+1]],[P[i],P[i+1],P[i+1]],color=:red)
end
plot!(legend=false)

number_of_iterations = 0
p = bisection(f,1.0,2.0)
@show number_of_iterations

g(x) = -1/3*(4-x^3)
h(x) = -x^2
a, b = 0.0, 4.0
p0 = 0.0
number_of_iterations = 0
p, P = picard(g,p0)
@show number_of_iterations
