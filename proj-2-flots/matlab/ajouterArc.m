% Créer de nouveaux arcs dans le graphe G.
function G=ajouterArc(G, s_deb, s_arr, value)
  if (s_deb < s_arr)
    G(s_deb, s_arr) = value;
  else
    G(s_arr, s_deb) = -value;
  end
end
