% Deformation de trajectoire
%
%cprintf([1,0,1],'  A COMPLETER');
%disp(' ');

nurbs = T(1).nurbs;
nurbs2 = nurbs;
nurbs2.coefs(:,5) = nurbs.coefs(:,5)*2;
nurbs2.coefs(:,6) = nurbs.coefs(:,6)/2;
T(1).nurbs = nurbs2;

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