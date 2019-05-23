using Plots

function bisection(f,a,b,tol=sqrt(eps((a+b/2))))
    @assert f(a) * f(b) < 0
    an = copy(a)
    bn = copy(b)
    A = [an]
    B = [bn]
    pn = (an+bn)/2
    P = [pn]
    while (bn-an) > 2*tol
        if f(pn) * f(an) < 0
            bn = pn
        else
            an = pn
        end
        push!(A,an)
        push!(B,bn)
        pn = (an+bn)/2
        push!(P,pn)
    end
    pn, P, A, B
end

f(x) = x^2 - 2
p, P, A, B = bisection(f,1.0,2.0, 1e-3)

scatter(P, f.(P))
y, dy = 0.0, 0.025
for (a,b) in zip(A,B)
    plot!([a,b],[y,y],line=2)
    global y += dy
end
scatter!([p], [f(p)], legend=false, marker=8)
