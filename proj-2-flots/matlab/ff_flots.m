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
nb_iter = 0;
while (continuer)
    disp('===========================');
    afficherGraphe(F);
    nb_iter = nb_iter + 1;
    flot_aux = [];
    beta = Inf;
    sommet_courant = s;
    voisins_visite = [s];
    chemin_ameliorant = [s];
    cond2 = 1;
    while (cond2 && (sommet_courant ~= t))
        disp('DEBUT ITER =======================================')
        sommet_courant
        VD = voisins_dir(F,sommet_courant)
        i = 1;
        disp('recherche parmi voisin direct')
        while ((i <= length(VD))  && ((size(find(voisins_visite==VD(i)),2)>0) || ((capacite(F,sommet_courant, VD(i)) - flot(F,VD(i), sommet_courant)) == 0)))
            VD(i)
            i = i + 1;
        end
        % (size(find(voisins_visite==VD(i),2)>=0) && (capacite(F,sommet_courant, VD(i)) - flot(F,VD(i), sommet_courant)) != 0))  || (i > length(VD))
        if (i <= length(VD) && (size(find(voisins_visite==VD(i)),2)==0))
            disp('Voisin directe possible');
            flot_aux = [flot_aux, 1];
            voisins_visite=[voisins_visite,VD(i)];   % on a le prochain voisin
            chemin_ameliorant = [chemin_ameliorant,VD(i)];
            beta = min(beta, capacite(F,sommet_courant, VD(i)) - flot(F,VD(i), sommet_courant));
            sommet_courant = VD(i);
            c = capacite(F,sommet_courant, VD(i)) - flot(F,VD(i), sommet_courant);
        else
            % on regarde les voisins indirect
            disp('recherche parmi voisins indirectes');
            VI = voisins_ind(F,sommet_courant)
            i = 1;
            while (i <= length(VI) && ((size(find(voisins_visite==VI(i)),2)>0) || (flot(F, VI(i), sommet_courant) <= 0)))
                VI(i)
                i = i + 1;
            end
            if (i <= length(VI) && (size(find(voisins_visite==VI(i)),2)==0))
                disp('Voisin indirecte possible');
                flot_aux = [flot_aux, -1];
                voisins_visite=[voisins_visite,VI(i)];   % on a le prochain voisin
                chemin_ameliorant = [chemin_ameliorant,VI(i)];
                beta = min(beta, flot(F,VI(i), sommet_courant));
                sommet_courant = VI(i);
            else
                % on ne peut pas continuer avec ce sommet
                % on doit retourner en arrière
                if (sommet_courant == 1)
                    continuer = 0;
                    cond2 = 0;
                    disp('sommet courant est la source !');
                else
                    disp('on retourne en arriere');
                    voisins_visite
                    chemin_ameliorant
                    chemin_ameliorant = chemin_ameliorant(1,1:size(chemin_ameliorant,2)-1)
                    sommet_courant = chemin_ameliorant(size(chemin_ameliorant,2))
                    flot_aux = flot_aux(1,1:size(flot_aux,2)-1);
                end
%                 continuer = 0;
%                 break
            end
        end
%         cond2 = ((sommet_courant ~= t) && (length(chemin_ameliorant) ~= 1));
        disp('FIN ITER ===========================================');
    end
    F = maj_flot(F, chemin_ameliorant, beta * flot_aux);
    if (length(chemin_ameliorant) == 1)
        continuer = 0;
    end
end % while principale

end % function