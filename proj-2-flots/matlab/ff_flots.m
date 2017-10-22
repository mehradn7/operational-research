% Algorithme de ford et fulkerson pour les flots
function F = ff_flots(G, s, t)
% Triangle inférieur de G => capacité des arrêtes de i->j
% si G(i,j) = 0 : aucune arrête entre i et j
% si G(i,j) > 0 : une arrête de capacité G(i,j) relie i->j
% si G(i,j) < 0 : une arrête de capacité -G(i,j) relie j->i
% Trangle supérieur de G => Flot courant sur l'arrête i-j
% G(j,i) indique le flot courant sur l'arrête i-j
% lG = [
% % 1 2 3 4  5 6  j/i
%   0 8 0 6  0 0; % 1
%   0 0 4 0  8 0; % 2
%   0 0 0 0 -2 6; % 3
%   0 0 0 0  6 0; % 4
%   0 0 0 0  0 8; % 5
%   0 0 0 0  0 0; % 6
%     ];


% function: Short description
F = G;
% Extended description
continuer = 1;  %  == true
while continuer
    flot_aux = [];
    beta = Inf;
    sommet_courant = s;
    voisins_visite = [s];
    while (sommet_courant ~= t)
        VD = voisins_dir(F,sommet_courant);
        i = 1;
        while ((i <= length(VD))  && (capacite(F,sommet_courant, VD(i)) - flot(F,VD(i), sommet_courant)) == 0)
            i = i + 1;
        end
        % not ((capacite(F,sommet_courant, VD(i)) - flot(F,VD(i), sommet_courant)) == 0)  || not (i < length(VD))
        if i <= length(VD)
            flot_aux = [flot_aux, 1];
            voisins_visite=[voisins_visite,VD(i)];   % on a le prochain voisin
            beta = min(beta, capacite(F,sommet_courant, VD(i)) - flot(F,VD(i), sommet_courant));
            sommet_courant = VD(i);
            c = capacite(F,sommet_courant, VD(i)) - flot(F,VD(i), sommet_courant);
        else
            % on regarde les voisins indirect
            VI = voisins_ind(F,sommet_courant);
            i = 1;
            while (i <= length(VI) && flot(VI(i), sommet_courant) < 0 )
                i = i + 1;
            end
            if i <= length(VI)
                flot_aux = [flot_aux, -1];
                voisins_visite=[voisins_visite,VI(i)];   % on a le prochain voisin
                beta = min(beta, flot(F,VI(i), sommet_courant));
                sommet_courant = VI(i);
            else
                % on ne peut pas continuer avec ce sommet
                % on doit retourner en arrière
                break
            end
        end
    end
    F = maj_flot(F, voisins_visite, beta * flot_aux)
    if length(flot_aux) == 0
        continuer = 0;
    end
end % while principale

end % function
