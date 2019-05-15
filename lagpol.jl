function lag_basis(k,nodes,x)
    nom = one(x)
    den = one(x)
    for i in eachindex(nodes)
        i == k && continue
        nom *= (x-nodes[i])
        den *= (nodes[k]-nodes[i])
    end
    nom / den
end

function lag_interpolant(X,Y)
    @assert length(X) == length(Y)
    function L(x)
        r = zero(x)
        for k in eachindex(X)
            r += Y[k] * lag_basis(k,X,x)
        end
        return r
    end
end
