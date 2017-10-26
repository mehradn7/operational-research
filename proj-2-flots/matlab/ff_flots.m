% Algorithme de Ford et Fulkerson pour les flots
function F = ff_flots(G, s, t)

%% EN ENTREE
%  G : le graphe dont on cherche à maximiser les flots
%  s : le sommet source
%  t : le sommet puits

%% EN SORTIE
%  F : le graphe obtenu (avec le flot traversant chaque arc)

% Représentation matricielle :

% -Triangle supérieur de G => capacité des arêtes de i->j
% Pour i<j :
% si G(i,j) = 0 : aucune arête entre i et j
% si G(i,j) > 0 : une arête de capacité G(i,j) relie i->j
% si G(i,j) < 0 : une arête de capacité -G(i,j) relie j->i

% -Triangle inférieur de G => Flot courant sur l'arête i-j
% G(j,i) indique le flot courant sur l'arête i-j
% Exemple : G = [
% % 1 2 3 4  5 6  j/i
%   0 8 0 6  0 0; % 1
%   0 0 4 0  8 0; % 2
%   0 0 0 0 -2 6; % 3
%   0 0 0 0  6 0; % 4
%   0 0 0 0  0 8; % 5
%   0 0 0 0  0 0; % 6
%     ];

F = G;

continuer = 1;  %  condition de continuation de l'algorithme
nb_iter = 0;
while (continuer)
    nb_iter = nb_iter + 1;
    flot_aux = [];
    beta = Inf;
    sommet_courant = s;
    voisins_visite = [s];
    chemin_ameliorant = [s];
    while (continuer && (sommet_courant ~= t))
        VD = voisins_dir(F,sommet_courant);
        i = 1;
        % recherche parmi voisins directs
        while ((i <= length(VD))  && ((size(find(voisins_visite==VD(i)),2)>0) || ((capacite(F,sommet_courant, VD(i)) - flot(F,VD(i), sommet_courant)) == 0)))
            i = i + 1;
        end
        % ((i > length(VD)) || ((size(find(voisins_visite==VD(i)),2)<=0) && ((capacite(F,sommet_courant, VD(i)) - flot(F,VD(i), sommet_courant)) != 0)))
        if (i <= length(VD) && (size(find(voisins_visite==VD(i)),2)==0))
            % Voisins directs possibles
            flot_aux = [flot_aux, 1];
            voisins_visite=[voisins_visite,VD(i)];   % on a le prochain voisin
            chemin_ameliorant = [chemin_ameliorant,VD(i)]; % on construit le chemin améliorant
            beta = min(beta, capacite(F,sommet_courant, VD(i)) - flot(F,VD(i), sommet_courant)); % mise à jour de beta
            sommet_courant = VD(i); % le sommet courant <- dernier élément du chemin améliorant
            c = capacite(F,sommet_courant, VD(i)) - flot(F,VD(i), sommet_courant);
        else
            % on regarde les voisins indirects
            VI = voisins_ind(F,sommet_courant);
            i = 1;
            while (i <= length(VI) && ((size(find(voisins_visite==VI(i)),2)>0) || (flot(F, VI(i), sommet_courant) <= 0)))
                VI(i)
                i = i + 1;
            end
            % (i > length(VI) || ((size(find(voisins_visite==VI(i)),2)<=0) && (flot(F, VI(i), sommet_courant) > 0)))
            
            % si un voisin indirect est possible :
            if (i <= length(VI) && (size(find(voisins_visite==VI(i)),2)==0))
                flot_aux = [flot_aux, -1];
                voisins_visite=[voisins_visite,VI(i)];   % on a le prochain voisin
                chemin_ameliorant = [chemin_ameliorant,VI(i)]; % on construit le chemin améliorant
                beta = min(beta, flot(F,VI(i), sommet_courant)); % mise à jour de beta
                sommet_courant = VI(i); % le sommet courant <- dernier élément du chemin améliorant
            else
                % on ne peut pas continuer avec ce sommet
                % on doit retourner en arrière
                if (sommet_courant == 1)
                    continuer = 0;  % sommet courant est la source : on arrête l'algo
                else
                    % on retourne en arriere 
                    chemin_ameliorant = chemin_ameliorant(1,1:size(chemin_ameliorant,2)-1);
                    sommet_courant = chemin_ameliorant(size(chemin_ameliorant,2));
                    flot_aux = flot_aux(1,1:size(flot_aux,2)-1);
                end
            end
        end
    end
    F = maj_flot(F, chemin_ameliorant, beta * flot_aux); % mise à jour du flot dans le graphe F
    if (length(chemin_ameliorant) == 1)
        continuer = 0; % on ne peut plus trouver de chemin améliorant : on arrête l'algo
    end
end % boucle while principale

end % function
