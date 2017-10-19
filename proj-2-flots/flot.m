% Calcul du flot de l'arrète reliant le sommet i et j du graphe G
function flot = flot(G, i, j)
    % pour le calcul du flot, G(i,j) a du sens que si i > j
    if i > j
        flot = abs(G(i,j));
    else
        flot = abs(G(j,i));
    end
end
