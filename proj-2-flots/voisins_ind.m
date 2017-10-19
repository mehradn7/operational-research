% Calcul des voisins indirectes d'un sommet i dans un graphe G connexe
function VI = voisins_ind(G, s)
  VI = [];
  for i=1:(s-1)
    if (G(i,s) > 0)
      VI.append(i)
    end
  end
  for i=(s+1):size(G,1)
    if (G(s,i) < 0)
      VI.append(i)
    end
  end
