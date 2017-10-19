% Algorithme de ford et fulkerson pour les flots

% Triangle inférieur de G => capacité des arrêtes de i->j
% si G(i,j) = 0 : aucune arrête entre i et j
% si G(i,j) > 0 : une arrête de capacité G(i,j) relie i->j
% si G(i,j) < 0 : une arrête de capacité -G(i,j) relie j->i
% Trangle supérieur de G => Flot courant sur l'arrête i-j
% G(j,i) indique le flot courant sur l'arrête i-j
G = [
% 1 2 3 4  5 6  j/i
  X 8 0 6  0 0; % 1
  0 X 4 0  8 0; % 2
  0 0 X 0 -2 6; % 3
  0 0 0 X  6 0; % 4
  0 0 0 0  X 8; % 5
  0 0 0 0  0 X; % 6
    ];


function F = FF_Flots(G, s, t)
% function: Short description
%
% Extended description

    continuer = 1;  %  == true
    while continuer
        flot_aux = [];
        beta = Inf;
        sommet_courant = s;
        voisins_visite = [s];
        ind_parc = 1;             % indice de parcours dans le graphe
        while (voisins_visite(ind_parc) ~= t)
            VD = voisins_dir(G,s);
            i = 1
            while (capa(sommet_courant, VD(i)) - flot(VD(i), sommet_courant)) == 0   % attention 1er terme enventuellement négatif
                i = i + 1;
            end
            if (i <= size(VD(1)))
                flot_aux.append(1);
                ind_parc = ind_parc + 1;
                voisins_visite.append(VD(i));   % on a le prochain voisin
                sommet_courant = VD(i);
                beta = min(beta, capa(sommet_courant, VD(i)) - flot(VD(i), sommet_courant));
            else
                % on regarde les voisins indirect
                VI = voisins_ind(G,s);
                i = 1
                while flot(VI(i), sommet_courant) < 0   % attention terme enventuellement négatif
                    i = i + 1;
                end
                if (i <= size(VI(1)))
                    flot_aux.append(1);
                    ind_parc = ind_parc + 1;
                    voisins_visite.append(VI(i));   % on a le prochain voisin
                    sommet_courant = VI(i);
                    beta = min(beta, flot(VI(i), sommet_courant));
                else
                    % on ne peut pas continuer avec ce sommet
                    % on doit retourner en arrière
                end
            end
            ind_parc = ind_parc + 1;
        end
        % maj du flot ( dans le graphe )
        voisins_visite = [];
    end
    % affectation des flots

end  % function
