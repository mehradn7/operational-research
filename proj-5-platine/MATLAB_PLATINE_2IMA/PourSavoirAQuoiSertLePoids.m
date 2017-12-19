% premiere etape : Lancer platine, demander 1, choisir scene1, puis arreter
% platine
nurbs = T(1).nurbs; % recuperation des caracteristiques de la trajectoire du premier robot
figure(1), clf, hold on, nrbplot(nurbs,subd,'m'); xlim([1 100]); ylim([1 100])%affichage de cette nurbs
coefs = nurbs.coefs;
set(gca, 'YDir', 'reverse');



ip = i;

for i=1:size(coefs,2)
    figure(1),hold on,
    plot(coefs(1,i)/coefs(4,i),coefs(2,i)/coefs(4,i),'b*') % affichage des points de controle
    % coefs(4,i) donne le poids associe au point numero i. Les coordonnees
    % reelles de Pi sont donnees par la formule :
    % Pi = (xi,yi,zi) = (coefs(1,i)/coefs(4,i), coefs(2,i)/coefs(4,i), coefs(3,i)/coefs(4,i))
    % NB : zi = 0 quelque soit i, puisqu'on est dans le plan.
end
% Maintenant, on relache le point de controle 6, et on force le 5;

nurbs2 = nurbs;
%nurbs2.coefs(:,4) = nurbs.coefs(:,4)/10;
nurbs2.coefs(:,9) = nurbs2.coefs(:,9);


i = 1; % 

p_aux = P(i).pp;
a_supp = p_aux(end);
p_aux(p_aux == a_supp) = [];
coll = diff(p_aux);
[~, col1] = find(coll == 0);
if (~isempty(col1))
col1 = col1(1);
xcol = xy(1, round(p_aux(col1)), i);
ycol = xy(2, round(p_aux(col1)), i);
figure(1),hold on,plot(xcol,ycol,'r*')
end
% Affichage de cette nouvelle nurbs sur la meme figure que la premiere :
figure(1), hold on, nrbplot(nurbs2,subd,'k-.')
figure(1), hold on, nrbplot(T(2).nurbs,subd,'k-.')

% On voit que la modif est tres locale

