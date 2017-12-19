% Deformation de trajectoire
%
cprintf([1,0,1],'  A COMPLETER');
disp(' ');

%% DEBUT AJOUT

% recupération du point de collision
i = 1;

p_aux = P(i).pp;
a_supp = p_aux(end);
p_aux(p_aux == a_supp) = [];
coll = diff(p_aux);
[~, col1] = find(coll == 0);
if (~isempty(col1))
col1 = col1(1);
xcol = xy(1, round(p_aux(col1)), i);
ycol = xy(2, round(p_aux(col1)), i);
end

% recherche du point de controle le plus proche du point de collision
nurbs = T(1).nurbs;

p_coll = [xcol ycol];
points = nurbs.coefs(1:2,:)./nurbs.coefs(4,:);
points = (points - p_coll') .* (points - p_coll');
v = points(1,:) + points(2,:);
[d_min, i_min] = min(v);
d_min = sqrt(d_min);
% disp('POINT MINIMUM DISTANCE')
% i_min
% point_c = nurbs.coefs(1:2,i_min)./nurbs.coefs(4,i_min)

tol = 10;
modif = 10;

% Détection trajectoires chevauchées rectiligne


%Trajectoire avec angle important

if (d_min/T(1).diametre_robot < tol)
    disp('Point de collision proche d un point de controle')
    nurbs2 = nurbs;
    nurbs2.coefs(:,i_min) = nurbs.coefs(:,i_min)/modif;
    nurbs2.coefs(:,9) = -nurbs2.coefs(:,9) * 100 ;
    T(1).nurbs = nurbs2;
end

%% FIN AJOUT


% Sauvegarde de la scene
reponse = input('Changement du nom de la scene ? [Y/N] ','s');
while reponse == 'Y'
    NOMSCENE = input('Nouveau nom de la scene : ','s');
    NOMFIC = ['Scenes/' NOMSCENE '.mat'];
    if exist(NOMFIC,'file') == 0
        disp ('OK'); % le fichier n'existe pas deja , c'est bon
        reponse = 'N';
    else
        % le fichier existe deja il faut donner un autre nom
        disp('le fichier existe deja il faut donner un autre nom');
    end
end
save(NOMFIC,'im','nombre_objets','subd','T');
%

%