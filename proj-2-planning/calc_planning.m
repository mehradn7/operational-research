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
A = zeros(size(x,2), size(b,2));

% constraints : I


% constraints : II, David & Romain
begin_2 = 0; % offset const to avoid conflicts of affectation with other constraints
n = 0; % (n+1)th constraint
for di = 1:d % loop on days, di is the current day
  for k = 1*di:t*di % loop on slots, k is the current slot in [|1, d*t|]
    A(begin_2+1, threeD2oneD(1,1,k)) = 1; % 1 : maths (a)
    A(begin_2+2, threeD2oneD(2,2,k)) = 1; % 2 : maths (b)
    for j = 1:c
      A(begin_2+2+j, threeD2oneD(3,j,k)) = 1; % 3, 4 : physique (a)
      A(begin_2+6+j, threeD2oneD(6,j,k)) = 1; % 7, 8 : anglais (a)
    end
    A(begin_2+5, threeD2oneD(4,1,k)) = 1; % 5 : informatique (a)
    A(begin_2+6, threeD2oneD(5,2,k)) = 1; % 6 : informatique (b)
    A(begin_2+9, threeD2oneD(7,1,k)) = 1; % 9 : sport (a)
    A(begin_2+10, threeD2oneD(8,2,k)) = 1; % 10 : sport (b)
  end
end


% constraints : III
% constraints : IV
