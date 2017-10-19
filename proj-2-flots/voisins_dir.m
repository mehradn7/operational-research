% Calcul des voisins directes d'un sommet i dans un graphe G connexe
function VD = voisins_dir(G, s)
  VD = [];
  for i=1:(s-1)
    if (G(i,s) < 0)
      VD.append(i)
    end
  end
  for i=(s+1):size(G,1)
    if (G(s,i) > 0)
      VD.append(i)
    end
  end
