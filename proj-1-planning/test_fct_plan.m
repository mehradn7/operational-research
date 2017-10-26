
clear;

c = 2; % nombre de promotions
profNames =   {'Droite', 'Ellips', 'Proton', 'Pascal', 'Delle', 'Young', 'Gazelle', 'Bigceps'}; % liste des professeurs
m = size(profNames, 2); % nombre de professeurs
%profNums = 1:m;
%profs = containers.Map(profNames, profNums); % profs('Droite') return 1
d = 5; % nombre de jours
t = 4+1; % nombre de créneaux par jour
I = 1:m; % intervalle professeurs
J = 1:c; % intervalle promotions
K = 1:d*t; % intervalle créneaux
begin_ineq = 1; % indice de la ligne à modifier dans les matrices A et b
begin_eq = 1; % indice de la ligne à modifier dans les matrices Aeq et beq

% === Initialisations ===

length_X = c*d*t*(m+1);
A = zeros(1,length_X);
b = [];

Aeq = zeros(1,length_X);
beq = [];
length_x = c*d*t*m;

% Contraintes portant sur le nombre de cours par jour et par matières
% [TEST1] Modifications des contraintes pour tests minimisation des trous
% 10 cours par semaine pour chaque promo, on ne s'attend à observer que des cours que sur le 2e et 3e créneau de la journée
profNames =   {'Droite', 'Ellips', 'Proton', 'Pascal', 'Delle', 'Young', 'Gazelle', 'Bigceps'}; % liste des professeurs
m = size(profNames, 2);

K = 1:d*t;
Aeq(1,threeD2oneD(1,1,K)) = 1;     beq(1) = 3;%Droite1
Aeq(2,threeD2oneD(2,2,K)) = 1;     beq(2) = 5;%Ellips2
Aeq(3,threeD2oneD(3,1,K)) = 1;     beq(3) = 3;%Proton1
Aeq(4,threeD2oneD(5,1,K)) = 1;     beq(4) = 6;%Delle1
Aeq(5,threeD2oneD(6,1,K)) = 1;     beq(5) = 3;%Young1
Aeq(6,threeD2oneD(8,2,K)) = 1;     beq(6) = 1;%bigceps2
Aeq(7,threeD2oneD(6,2,K)) = 1;     beq(7) = 3;%Young2
Aeq(8,threeD2oneD(3,2,K)) = 1;     beq(8) = 3;%Proton2
Aeq(9,threeD2oneD(4,1,K)) = 1;     beq(9) = 0;%Pascal-1
Aeq(10,threeD2oneD(1,2,K)) = 1;     beq(10) = 0;%Droite-2
Aeq(11,threeD2oneD(4,2,K)) = 1;     beq(11) = 6;%Pascal2
Aeq(12,threeD2oneD(5,2,K)) = 1;     beq(12) = 0;%Delle-2
Aeq(13,threeD2oneD(2,1,K)) = 1;     beq(13) = 0;%Ellips-1
% Aeq(10,threeD2oneD(3,2,K)) = 1;    beq(10) = 1;
% Aeq(11,threeD2oneD(4,1,K)) = 1;    beq(11) = 3;
% Aeq(12,threeD2oneD(5,2,K)) = 1;    beq(12) = 3;
% Aeq(13,threeD2oneD(6,1,K)) = 1;    beq(13) = 2;
% Aeq(14,threeD2oneD(6,2,K)) = 1;    beq(14) = 2;
% Aeq(15,threeD2oneD(7,1,K)) = 1;   beq(15) = 1;
% Aeq(16,threeD2oneD(I,j,K)) = 1;   beq(16) = 1;
% Aeq(17,threeD2oneD(I,j,K)) = 1;    beq(17) = 0;
% Aeq(18,threeD2oneD(I,j,K)) = 1;    beq(18) = 0;
% Aeq(19,threeD2oneD(I,j,K)) = 1; beq(19) = 0;



% % [TEST2] Rajout de contraintes pour tester chaque contrainte imposée (aucune solution trouvée attendue lors de l'utilisation d'une de ces contraintes)
% Aeq(20,1,2,20) = 1;     beq(20) = 1;
% Aeq(20,2,1,20) = 1;     beq(20) = 1;
% Aeq(20,4,2,20) = 1;     beq(20) = 1;
% Aeq(20,5,1,20) = 1;     beq(20) = 1;
% Aeq(20,7,2,20) = 1;     beq(20) = 1;
% Aeq(20,8,1,20) = 1;     beq(20) = 1;
% 
% % [TEST3] Pour vérifier l'efficacité de la 9eme contrainte, on impose 4 cours pour le groupe 1 à Mme Proton (alors qu'elle ne doit en assurer que 3 par semaine). Le raisonnement sera le même pour les autres profs (leur nombre de cours à respecter) et l'autre groupe.
% Aeq(20,3,1,20) = 1;     beq(20) = 1;
% Aeq(21,3,1,5) = 1;     beq(21) = 1;
% Aeq(22,3,1,13) = 1;     beq(22) = 1;
% Aeq(23,3,1,17) = 1;     beq(23) = 1;
% 
% % [TEST4] Pour vérifier que le créneau dédié au sport est réservé (le 15)
% Aeq(20,4,2,15) = 1;     beq(20) = 1;
% 
% % [TEST5] Pour vérifier que le créneau dédié au partiel est réservé (le 1)
% Aeq(20,4,2,1) = 1; beq(20) = 1;


Planning_fct(A,b,Aeq,beq,c,m,d,t)


