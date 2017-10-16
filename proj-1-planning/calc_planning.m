% Solve the min pb about planning with linprog
function X = calc_planning()
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

% == Init parameters ==
% Prof related number
c = 2;
profNames =   {'Droite', 'Ellips', 'Proton', 'Pascal', 'Delle', 'Young', 'Gazelle', 'Bigceps'};
p = size(profNames, 2);
profNums = 1:p;
profs = containers.Map(profNames, profNums); % profs('Droite') return 1
d = 5;
t = 4;
length_X = c*d*t*(p+1);
A = zeros(1,length_X);
% A = [];
b = [];
Aeq = zeros(1,length_X);
% Aeq = [];
beq = [];
length_x = c*d*t*p;
f = zeros(length_X,1);
f(length_x+1:length_X,1) = ones(c*d*t,1);
lb = zeros(length_X,1);
ub = ones(length_X,1);

I = 1:p; %scale on teachers
J = 1:c; %scale on classes


% constraints : I

% offset consts to avoid conflicts of affectation with other constraints
begin_ineq = 1; % index of the modified row in A,b
begin_eq = 1; % index of the modified row in Aeq,beq

for j=1:c
  for k=1:t*d
    for u=1:(mod(k,t)-1)
      for v=1:(t - mod(k,t))
        if (~(mod(k,t)==0 || mod(k,t)==1))
          K =[k-u , k+v , k];
          A(begin_ineq, twoD2oneD(j,k)) = -1;
		      for i=1:p
            A(begin_ineq, threeD2oneD(i,j,K)) = [ 1 , 1 , -1];  % the three last terms
          end
 		      b(begin_ineq,1) = 1;
          begin_ineq = begin_ineq + 1;
        end
      end
    end
  end
end


% constraints : II, David & Romain
for di = 1:d % loop on days, di is the current day
  K = (di-1)*t+1:t*di; % scale on slots
  A(begin_ineq+1, threeD2oneD(1,1,K)) = ones(1,t); % 1 : maths (a)
  A(begin_ineq+2, threeD2oneD(2,2,K)) = ones(1,t); % 2 : maths (b)s
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


% Sport courses are thursday afternoon between 2pm and 4pm
Aeq(begin_eq+1,threeD2oneD(7,1,15))=1;
beq(begin_eq+1,1)=1;

Aeq(begin_eq+2,threeD2oneD(8,2,15))=1;
beq(begin_eq+2)=1;

% % % % % % % Aeq(begin_eq+10,:)=ones(1,length_X);
% % % % % % % Aeq(begin_eq+10,threeD2oneD(7,1,15))=0;
% % % % % % % beq(begin_eq+10)=0;
% % % % % % % 
% % % % % % % Aeq(begin_eq+11,:)=ones(1,length_X);
% % % % % % % Aeq(begin_eq+11,threeD2oneD(8,2,15))=0;
% % % % % % % beq(begin_eq+11)=0;

% %Mr Young(6), 3 courses with classe 1 and 3 courses with classe 2
Aeq(begin_eq+3,threeD2oneD(6,1,1:d*t))=ones(1,d*t);
beq(begin_eq+3)=3;
Aeq(begin_eq+4,threeD2oneD(6,2,1:d*t))=ones(1,d*t);
beq(begin_eq+4)=3;
%Le first slot on monday morning is for exam % TODO
Aeq(begin_eq+5,threeD2oneD(I,1,1))=ones(1,p);
Aeq(begin_eq+6,threeD2oneD(I,2,1))=ones(1,p);
beq(begin_eq+5)=0;
beq(begin_eq+6)=0;
%Mr Ellips(2) is no available on monday morning % TODO
Aeq(begin_eq+7,threeD2oneD(2,2,1:2))=ones(1,2);
beq(begin_eq+7)=0;
%Ms Proton(3) is not available on wednesday % TODO
wednesday=9:12;
Aeq(begin_eq+8,threeD2oneD(3,1,wednesday))=ones(1,t);
Aeq(begin_eq+9,threeD2oneD(3,2,wednesday))=ones(1,t);
beq(begin_eq+8)=0;
beq(begin_eq+9)=0;

begin_eq = begin_eq + 12;
% 
% %A teacher only have a course with a classe by slot Proton(3) et Young(6)
% %begin_ineq: current index for inegalities
% for k = 1:d*t % loop on slots, k is the current slot
%     A(begin_ineq+1,threeD2oneD(3,J,k))=ones(1,2);
%     b(begin_ineq+1)=1;
%     A(begin_ineq+2,threeD2oneD(6,J,k))=ones(1,2);
%     b(begin_ineq+2)=1;
%     begin_ineq=begin_ineq+2;
% end
% 
% constraints : IV
K=1:d*t;

% Droite
Aeq(begin_eq, threeD2oneD(1,2,K))=ones(1,d*t);
beq(begin_eq)=0;
begin_eq=begin_eq+1;

% Droite
Aeq(begin_eq, threeD2oneD(1,1,K))=ones(1,d*t);
beq(begin_eq)=3;
begin_eq=begin_eq+1;

% % Ellips
% 
% Aeq(begin_eq, threeD2oneD(2,1,K))=ones(1,d*t);
% beq(begin_eq)=0;
% begin_eq=begin_eq+1;
% 
% % Ellips
% 
% Aeq(begin_eq, threeD2oneD(2,2,K))=ones(1,d*t);
% beq(begin_eq)=4;
% begin_eq=begin_eq+1;
% 
% % Proton
% 
% Aeq(begin_eq, threeD2oneD(3,1,K))=ones(1,d*t);
% beq(begin_eq)=3;
% begin_eq=begin_eq+1;
% 
% % Proton
% 
% Aeq(begin_eq, threeD2oneD(3,2,K))=ones(1,d*t);
% beq(begin_eq)=3;
% begin_eq=begin_eq+1;
% 
% % Pascal
% 
% Aeq(begin_eq, threeD2oneD(4,2,K))=ones(1,d*t);
% beq(begin_eq)=0;
% begin_eq=begin_eq+1;
% 
% % Pascal
% 
% Aeq(begin_eq, threeD2oneD(4,1,K))=ones(1,d*t);
% beq(begin_eq)=6;
% begin_eq=begin_eq+1;
% 
% % Delle
% 
% Aeq(begin_eq, threeD2oneD(5,1,K))=ones(1,d*t);
% beq(begin_eq)=0;
% begin_eq=begin_eq+1;
% 
% Delle

% Aeq(begin_eq, threeD2oneD(5,2,K))=ones(1,d*t);
% beq(begin_eq)=6;
% begin_eq=begin_eq+1;
% 
% 
% % constraints : V
% 
% Plusieurs professeurs ne peuvent pas donner cours sur un même créneau
I = 1:p;
for j=1:c
    for k=1:d*t
      A(begin_ineq, threeD2oneD(I,j,k))=ones(1,p);
      b(begin_ineq)=1;
      begin_ineq=begin_ineq+1;
    end
end
% 
% % Le professeur Young ne peut pas donner cours à plusieurs promos sur le même créneau
% 
% J = 1:c;
% for k=1:d*t
%     A(begin_ineq, threeD2oneD(6,J,k))=ones(1,c);
%     b(begin_ineq)=1;
%     begin_ineq=begin_ineq+1;
% end
% 
% % Le professeur Proton ne peut pas donner cours à plusieurs promos sur le même créneau
% 
% J = 1:c;
% for k=1:d*t
%     A(begin_ineq, threeD2oneD(3,J,k))=ones(1,c);
%     b(begin_ineq)=1;
%     begin_ineq=begin_ineq+1;
% end

X = intlinprog(f,1:length_X,A,b,Aeq,beq,lb,ub);

% Initialiastion des promos
Promo1 = zeros(t,d);
Promo2 = zeros(t,d);
    for i=1:t
        for j=1:d
            for k=1:p
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

AffichagePromo1