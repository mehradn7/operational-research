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

% constraints : I


% constraints : II, David & Romain
begin_2 = 0; % offset const to avoid conflicts of affectation with other constraints
n = 0; % (n+1)th constraint
for di = 1:d % loop on days, di is the current day
  K = (di-1)*t+1:t*di; % scale on slots
  A(begin_2+1, threeD2oneD(1,1,K)) = ones(1,t); % 1 : maths (a)
  A(begin_2+2, threeD2oneD(2,2,K)) = ones(1,t); % 2 : maths (b)
  J = 1:c; % scale on classes
  A(begin_2+3:begin_2+3+(c-1), threeD2oneD(3,J,K)) = ones(1,t); % 3, 4 : physique (a)
  A(begin_2+7:begin_2+7+(c-1), threeD2oneD(6,J,K)) = ones(1,t); % 7, 8 : anglais (a)
  A(begin_2+5, threeD2oneD(4,1,K)) = ones(1,t); % 5 : informatique (a)
  A(begin_2+6, threeD2oneD(5,2,K)) = ones(1,t); % 6 : informatique (b)
  A(begin_2+9, threeD2oneD(7,1,K)) = ones(1,t); % 9 : sport (a)
  A(begin_2+10, threeD2oneD(8,2,K)) = ones(1,t); % 10 : sport (b)
  b(begin_2+1:begin_2+10) = ones(10,1); % for all constraints = 1
  b(begin_2+5:begin_2+6) = 2*ones(2,1); % 5,6 : informatique (a,b)
end


% constraints : III
% constraints : IV
