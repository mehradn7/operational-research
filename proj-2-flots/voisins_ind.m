% Calcul des voisins indirectes d'un sommet i dans un graphe G connexe
function VD = voisins_ind(G, i)
  VD = [];
  for j=1:size(G,1)
    if (G(i,j) < 0)
      VD.append(j);
    end
  end
