% Calcul la capacité de l'arrète reliant le sommet i et j du graphe G
function capa = capacite(G, i, j)
    % pour le calcul d'un capacité, G(i,j) a du sens que si i < j
    if i < j
        capa = abs(G(i,j));
    else
        capa = abs(G(j,i));
    end
end
