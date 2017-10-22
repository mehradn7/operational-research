% Mise a jour du flot dans un graphe G connexe
function newG = maj_flot(G, VV, flot_aux)
    newG = G;
    for i=1:(length(VV)-1)
        if (VV(i) > VV(i+1))
            newG(VV(i), VV(i+1)) = newG(VV(i), VV(i+1)) + flot_aux(i);
        else
            newG(VV(i+1), VV(i)) = newG(VV(i+1), VV(i)) + flot_aux(i);
        end
    end
end
