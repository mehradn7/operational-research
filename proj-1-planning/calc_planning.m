
% Solve the min pb about planning with linprog
function X = calc_planning()
clear;
% === Variables ===

c = 2; % nombre de promotions
profNames =   {'Droite', 'Ellips', 'Proton', 'Pascal', 'Delle', 'Young', 'Gazelle', 'Bigceps'}; % liste des professeurs
m = size(profNames, 2); % nombre de professeurs
%profNums = 1:m;
%profs = containers.Map(profNames, profNums); % profs('Droite') return 1
d = 5; % nombre de jours
t = 4; % nombre de créneaux par jour
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
f = zeros(length_X,1);
f(length_x+1:length_X,1) = ones(c*d*t,1);
lb = zeros(length_X,1);
ub = ones(length_X,1);




% Contrainte correspondant à la minimisation du nombre de trous dans
% l'emploi du temps

for j=1:c
  for k=1:20
    for u=1:(mod(k,t)-1)
      for v=1:(t - mod(k,t))
        if (~(mod(k,t)==0 || mod(k,t)==1))
            L =[k-u , k+v , k];
            A(begin_ineq, twoD2oneD(j,k)) = -1;
		    for i=1:m
                A(begin_ineq, threeD2oneD(i,j,L)) = [ 1 , 1 , -1];  % the three last terms
            end
             	b(begin_ineq,1) = 1;
                begin_ineq = begin_ineq + 1;
        end
      end
    end
  end
end



% Contraintes portant sur le nombre de cours par jour et par matières

for di = 1:d % on parcourt tous les jours, di est le jour courant
  L = (di-1)*t+1:t*di; % intervalle créneaux
  A(begin_ineq+1, threeD2oneD(1,1,L)) = ones(1,t); % 1 : maths (a)
  A(begin_ineq+2, threeD2oneD(2,2,L)) = ones(1,t); % 2 : maths (b)s
	for j=1:c
		A(begin_ineq+3+(j-1), threeD2oneD(3,j,L)) = ones(1,t); % 3, 4 : physique (a)
		A(begin_ineq+7+(j-1), threeD2oneD(6,j,L)) = ones(1,t); % 7, 8 : anglais (a)
	end
  A(begin_ineq+5, threeD2oneD(4,1,L)) = ones(1,t); % 5 : informatique (a)
  A(begin_ineq+6, threeD2oneD(5,2,L)) = ones(1,t); % 6 : informatique (b)
  A(begin_ineq+9, threeD2oneD(7,1,L)) = ones(1,t); % 9 : sport (a)
  A(begin_ineq+10, threeD2oneD(8,2,L)) = ones(1,t); % 10 : sport (b)
  b(begin_ineq+1:begin_ineq+10) = ones(10,1); % for all constraints = 1
  b(begin_ineq+5:begin_ineq+6) = 2*ones(2,1); % 5,6 : informatique (a,b)
  begin_ineq = begin_ineq + 11;
end


% Le cours de sport pour la promotion 1 a lieu le jeudi de 14h à 16h avec
% le professeur Gazelle

Aeq(begin_eq,threeD2oneD(7,1,15))=1;
beq(begin_eq,1)=1;
begin_eq=begin_eq+1;

% Professeur Gazelle donne 1 cours par semaine à la promotion 1

Aeq(begin_eq,threeD2oneD(7,1,K))=1;
beq(begin_eq,1)=1;
begin_eq=begin_eq+1;

% Professeur Gazelle ne donne aucun cours à la promotion 2

Aeq(begin_eq,threeD2oneD(7,2,K))=1;
beq(begin_eq,1)=0;
begin_eq=begin_eq+1;


% Le cours de sport pour la promotion 2 a lieu le jeudi de 14h à 16h avec
% le professeur Bigceps

Aeq(begin_eq,threeD2oneD(8,2,15))=1;
beq(begin_eq)=1;
begin_eq=begin_eq+1;

% Professeur Bigceps donne 1 cours par semaine à la promotion 2

Aeq(begin_eq,threeD2oneD(8,2,K))=1;
beq(begin_eq)=1;
begin_eq=begin_eq+1;

% Professeur Bigceps ne donne aucun cours à la promotion 1

Aeq(begin_eq,threeD2oneD(8,1,K))=1;
beq(begin_eq)=0;
begin_eq=begin_eq+1;


% Professeur Young assure 3 cours par semaine pour chaque promotion

Aeq(begin_eq,threeD2oneD(6,1,K))=1;
beq(begin_eq)=3;
begin_eq=begin_eq+1;

Aeq(begin_eq,threeD2oneD(6,2,K))=1;
beq(begin_eq)=3;
begin_eq=begin_eq+1;

% Le premier créneau du lundi matin est reservé au partiel

Aeq(begin_eq,threeD2oneD(I,1,1))=ones(1,m);
beq(begin_eq)=0;
begin_eq=begin_eq+1;

Aeq(begin_eq,threeD2oneD(I,2,1))=ones(1,m);
beq(begin_eq)=0;
begin_eq=begin_eq+1;


% Professeur Ellips n'est pas disponible le lundi matin

Aeq(begin_eq,threeD2oneD(2,2,1:2))=ones(1,2);
beq(begin_eq)=0;
begin_eq=begin_eq+1;

% Professeur Proton ne peut pas travailler le mercredi

wednesday=9:12;

Aeq(begin_eq,threeD2oneD(3,1,wednesday))=ones(1,t);
beq(begin_eq)=0;
begin_eq=begin_eq+1;

Aeq(begin_eq,threeD2oneD(3,2,wednesday))=ones(1,t);
beq(begin_eq)=0;
begin_eq=begin_eq+1;


%A teacher only have a course with a classe by slot Proton(3) et Young(6)

for k = 1:d*t % loop on slots, k is the current slot
    A(begin_ineq+1,threeD2oneD(3,J,k))=ones(1,2);
    b(begin_ineq+1)=1;
    A(begin_ineq+2,threeD2oneD(6,J,k))=ones(1,2);
    b(begin_ineq+2)=1;
    begin_ineq=begin_ineq+2;
end

%K=1:d*t;


% Professeur Droite ne donne aucun cours à la promotion 2

Aeq(begin_eq, threeD2oneD(1,2,K))=ones(1,d*t);
beq(begin_eq)=0;
begin_eq=begin_eq+1;

% Professeur Droite donne 5 cours par semaine à la promotion 1

Aeq(begin_eq, threeD2oneD(1,1,K))=ones(1,d*t);
beq(begin_eq)=5;
begin_eq=begin_eq+1;

% Professeur Ellips ne donne aucun cours à la promotion 1

Aeq(begin_eq, threeD2oneD(2,1,K))=ones(1,d*t);
beq(begin_eq)=0;
begin_eq=begin_eq+1;

% Professeur Ellips donne 4 cours par semaine à la promotion 2
 
Aeq(begin_eq, threeD2oneD(2,2,K))=ones(1,d*t);
beq(begin_eq)=4;
begin_eq=begin_eq+1;
 
% Professeur Proton donne 3 cours par semaine à la promotion 1

Aeq(begin_eq, threeD2oneD(3,1,K))=ones(1,d*t);
beq(begin_eq)=3;
begin_eq=begin_eq+1;

% Professuer Proton donne 3 cours par semaine à la promotion 2
 
Aeq(begin_eq, threeD2oneD(3,2,K))=ones(1,d*t);
beq(begin_eq)=3;
begin_eq=begin_eq+1;
 
% Professeur Pascal ne donne aucun cours à la promotion 2

Aeq(begin_eq, threeD2oneD(4,2,K))=ones(1,d*t);
beq(begin_eq)=0;
begin_eq=begin_eq+1;

% Professeur Pascal donne 6 cours par semaine à la promotion 1
 
Aeq(begin_eq, threeD2oneD(4,1,K))=ones(1,d*t);
beq(begin_eq)=6;
begin_eq=begin_eq+1;

% Professeur Delle ne donne aucun cours à la promotion 1
 
Aeq(begin_eq, threeD2oneD(5,1,K))=ones(1,d*t);
beq(begin_eq)=0;
begin_eq=begin_eq+1;
 
% Professeur Delle donne 6 cours par semaine à la promotion 2

Aeq(begin_eq, threeD2oneD(5,2,K))=ones(1,d*t);
beq(begin_eq)=6;
begin_eq=begin_eq+1;


% Plusieurs professeurs ne peuvent pas donner cours sur un même créneau

%I = 1:m;
for j=1:c
    for k=1:d*t
      A(begin_ineq, threeD2oneD(I,j,k))=ones(1,m);
      b(begin_ineq)=1;
      begin_ineq=begin_ineq+1;
    end
end
 
% Le professeur Young ne peut pas donner cours à plusieurs promos sur le même créneau

%J = 1:c;
for k=1:d*t
    A(begin_ineq, threeD2oneD(6,J,k))=ones(1,c);
    b(begin_ineq)=1;
    begin_ineq=begin_ineq+1;
end
 
% Le professeur Proton ne peut pas donner cours à plusieurs promos sur le même créneau
 
J = 1:c;
for k=1:d*t
    A(begin_ineq, threeD2oneD(3,J,k))=ones(1,c);
    b(begin_ineq)=1;
    begin_ineq=begin_ineq+1;
end

X = intlinprog(f,1:length_X,A,b,Aeq,beq,lb,ub);

disp('The result is:---------------------------------------------------------------------------------------------------')
length(find(0.5<=X))
X(length_x+1:length_X,1);
X(threeD2oneD(1:8,1,6));
X(find(0.5<=X))=1



% Initialiastion des promos
Promo1 = zeros(t,d);
Promo2 = zeros(t,d);
    for i=1:t
        for j=1:d
            for k=1:m
              nb_cren = (j-1)*t + i;
              if (X(threeD2oneD(k,1,nb_cren),1) == 1)
                Promo1(i,j) = k;
              end
              if (X(threeD2oneD(k,2,nb_cren),1) == 1)
                Promo2(i,j) = k;
              end
            end
        end
    end

AffichagePromo1;
figure();
AffichagePromo2;
