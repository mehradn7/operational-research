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


Planning_fct(A,b,Aeq,beq,c,m,d,t)


