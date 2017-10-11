% Solve the min pb about planning with linprog

% === Variables ===
% i_x : index in vector X
% i_m : index in matrix X, teachers (profs)
% j_m : index in matrix X, classes (promos)
% k_m : index in matrix X, slot (créneaux)
% profs : dic with prof names and corresponding value
% c : number of classes
% p : number of teachers
% d : number of days
% t : number of slots/days, d*t : total number of slots in a week
% Aeq, beq : represent egality constraints
% A, b : represent inegality constraints
% == === === === ==

% == bijection between i_x <-> (i_m, j_m, k_m) ==
% i_x = (i_m-1)*p*d*t + (j_m-1)*d*t + k_m
% i_m = fix(i_x/(p*d*t)) + 1
% rest_i_m = mod(i_m, p*d*t)
% j_m = fix(rest_i_m/(d*t)) + 1
% k_m = mod(rest_i_m, d*t)
% == === === === ==

% == Init parameters ==
% Prof related number
c = 2;
profNames =   {'Droite', 'Ellips', 'Proton', 'Pascal', 'Delle', 'Young', 'Gazelle', 'Bigceps'};
p = size(profNames, 2);
profNums = 1:p;
profs = containers.Map(profNames, profNums); % profs('Droite') return 1
d = 5;
t = 4;
b = zeros(nb_constraints, 1);
A = zeros(size(x,2), size(b,2));

I = 1:p; %scale on teachers
J = 1:c; % scale on classes


% constraints : I

% offset const to avoid conflicts of affectation with other constraints

begin_ineq = 1; % indice de la ligne a modifié dans A et b
begin_eq = 1; % indice de la ligne a modifié dans Aeq et beq


for j=1:c
    for k=1:t*d
        for u=1:(mod(k,t)-1)
            for v=1:(t - mod(k,t))
                if ~(mod(k,t)==0 || mod(k,t)==1)
                    K =[k-u , k+v , k];
		            A(begin_ineq, threeD2oneD_t(j,k)) = -1;% tj,k
		            for i=1:p
                    	A(begin_ineq, threeD2oneD(i,j,K)) = [ 1 , 1 , -1];  % les trois termes restants
                    end
		            b(begin_ineq) = 1;
                    begin_ineq = begin_ineq + 1;
                end
            end
        end
    end
end


% constraints : II, David & Romain
% offset const to avoid conflicts of affectation with other constraints
n = 0; % (n+1)th constraint
for di = 1:d % loop on days, di is the current day
  K = (di-1)*t+1:t*di; % scale on slots
  A(begin_ineq+1, threeD2oneD(1,1,K)) = ones(1,t); % 1 : maths (a)
  A(begin_ineq+2, threeD2oneD(2,2,K)) = ones(1,t); % 2 : maths (b)
  J = 1:c; % scale on classes
	for j=1:c
		A(begin_ineq+3+(j-1), threeD2oneD(3,j,K)) = ones(1,t); % 3, 4 : physique (a)
		A(begin_ineq+7+(j-1), threeD2oneD(6,j,K)) = ones(1,t); % 7, 8 : anglais (a)
	end
  A(begin_ineq+5, threeD2oneD(4,1,K)) = ones(1,t); % 5 : informatique (a)
  A(begin_ineq+6, threeD2oneD(5,2,K)) = ones(1,t); % 6 : informatique (b)
  A(begin_ineq+9, threeD2oneD(7,1,K)) = ones(1,t); % 9 : sport (a)
  A(begin_ineq+10, threeD2oneD(8,2,K)) = ones(1,t); % 10 : sport (b)
  b(begin_ineq+1:begin_ineq+10) = ones(10,1); % for all constraints = 1
  b(begin_ineq+5:begin_ineq+6) = 2*ones(2,1); % 5,6 : informatique (a,b)
  begin_ineq = begin_ineq + 11;
end


% constraints : III


%Les cours de sport ont lieu le jeudi après-midi de 14h à 16h
Aeq(begin_eq+1,threeD2oneD(7,1,15))=1;
beq(begin_eq+1,threeD2oneD(7,1,15))=1;
Aeq(begin_eq+2,threeD2oneD(8,2,15))=1;
beq(begin_eq+1,threeD2oneD(8,2,15))=1;
Aeq(begin_eq+10,:)=ones(1,size(x,1));
Aeq(begin_eq+10,threeD2oneD(7,1,15))=0;
Aeq(begin_eq+11,:)=ones(1,size(x,1));
Aeq(begin_eq+11,threeD2oneD(8,2,15))=0;

%Mr Young(6), 3 cours pour la promo 1 et 3 cours pour la promo 2
Aeq(begin_eq+3,threeD2oneD(6,1,1:d*t))=ones(1,d*t);
beq(begin_eq+3)=3;
Aeq(begin_eq+4,threeD2oneD(6,2,1:d*t))=ones(1,d*t);
beq(begin_eq+4)=3;
%Le premier créneau du lundi matin est réservé au partiel
Aeq(begin_eq+5,threeD2oneD(I,1,1))=ones(1,p);
Aeq(begin_eq+6,threeD2oneD(I,2,1))=ones(1,p);
beq(begin_eq+5)=0;
beq(begin_eq+6)=0;
%Mr Ellips(2) est indisponible le lundi matin
Aeq(begin_eq+7,threeD2oneD(2,2,1:2))=ones(1,2);
beq(begin_eq+7)=0;
%Mme Proton (3) ne peut pas travailler le mercredi
mercredi=9:12;
Aeq(begin_eq+8,threeD2oneD(3,1,mercredi))=ones(1,t);
Aeq(begin_eq+9,threeD2oneD(3,2,mercredi))=ones(1,t);
beq(begin_eq+8)=0;
beq(begin_eq+9)=0;

begin_eq = begin_eq + 12;

%Un prof a un cours avec une seule promo dans un creneau Proton (3) et
%Young (6)
%begin_ineq: indice courant des inégalités
for k = 1:d*t % loop on slots, k is the current slot
    A(begin_ineq+1,threeD2oneD(3,J,k))=ones(1,2);
    b(begin_ineq+1)=1;
    A(begin_ineq+2,threeD2oneD(6,J,k))=ones(1,2);
    b(begin_ineq+2)=1;
    begin_ineq=begin_ineq+2;
end
% constraints : IV

K=1:d*t;

% Droite

Aeq(begin_eq, threeD2oneD(1,2,K))=ones(1,d*t);
beq(begin_eq)=0;
begin_eq=begin_eq+1;

% Droite

Aeq(begin_eq, threeD2oneD(1,1,K))=ones(1,d*t);
beq(begin_eq)=5;
begin_eq=begin_eq+1;

% Ellips

Aeq(begin_eq, threeD2oneD(2,1,K))=ones(1,d*t);
beq(begin_eq)=0;
begin_eq=begin_eq+1;

% Ellips

Aeq(begin_eq, threeD2oneD(2,2,K))=ones(1,d*t);
beq(begin_eq)=4;
begin_eq=begin_eq+1;

% Proton

Aeq(begin_eq, threeD2oneD(3,1,K))=ones(1,d*t);
beq(begin_eq)=3;
begin_eq=begin_eq+1;

% Proton

Aeq(begin_eq, threeD2oneD(3,2,K))=ones(1,d*t);
beq(begin_eq)=3;
begin_eq=begin_eq+1;

% Pascal

Aeq(begin_eq, threeD2oneD(4,2,K))=ones(1,d*t);
beq(begin_eq)=0;
begin_eq=begin_eq+1;

% Pascal

Aeq(begin_eq, threeD2oneD(4,1,K))=ones(1,d*t);
beq(begin_eq)=6;
begin_eq=begin_eq+1;

% Delle

Aeq(begin_eq, threeD2oneD(5,1,K))=ones(1,d*t);
beq(begin_eq)=0;
begin_eq=begin_eq+1;

% Delle

Aeq(begin_eq, threeD2oneD(5,2,K))=ones(1,d*t);
beq(begin_eq)=6;
begin_eq=begin_eq+1;


% constraints : V

% Plusieurs professeurs ne peuvent pas donner cours sur un même créneau

for j=1:c
    for k=1:d*t
      A(begin_ineq, threeD2oneD(I,j,k))=ones(1,m);
      b(begin_ineq)=1;
      begin_ineq=begin_ineq+1;
    end
end

% Le professeur Young ne peut pas donner cours à plusieurs promos sur le même créneau

for k=1:d*t
    A(begin_ineq, threeD2oneD(6,J,k))=ones(1,c);
    b(begin_ineq)=1;
    begin_ineq=begin_ineq+1;
end

% Le professeur Proton ne peut pas donner cours à plusieurs promos sur le même créneau

for k=1:d*t
    A(begin_ineq, threeD2oneD(3,J,k))=ones(1,c);
    b(begin_ineq)=1;
    begin_ineq=begin_ineq+1;
end
