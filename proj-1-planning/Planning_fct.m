% Solve the min pb about planning with linprog
% c nombre de promotions
% m nombre de professeurs
% d nombre de jours
% t nombre de créneaux par jour
% A_in,b_in: matrices des contraintes d'inegalité A_in*X <= b_in
             %size(A_in,1)==size(b_in,1)
             %size(A_in,2)==size(X,1)==c*d*t*(m+1)
% Aeq_in,beq_in: matrices des contraintes d'egalité Aeq_in*X = beq_in
             %size(Aeq_in,1)==size(beq_in,1)
             %size(Aeq_in,2)==size(X,1)==c*d*t*(m+1)
function X = Planning_fct(A_in,b_in,Aeq_in,beq_in,c,m,d,t)


% === Variables ===
I = 1:m; % intervalle professeurs
J = 1:c; % intervalle promotions
K = 1:d*t; % intervalle créneaux

% === Initialisations ===
length_X = c*d*t*(m+1);
A = A_in;
b = b_in;
Aeq = Aeq_in;
beq = beq_in;
begin_ineq = size(A,1)+1; % indice de la ligne à modifier dans les matrices A et b
begin_eq = size(Aeq,1)+1; % indice de la ligne à modifier dans les matrices Aeq et beq

length_x = c*d*t*m;
f = zeros(length_X,1);% f la fonction à minimiser
f(length_x+1:length_X,1) = ones(c*d*t,1);
size(f)
lb = zeros(length_X,1);
ub = ones(length_X,1);

% Contrainte correspondant à la minimisation du nombre de trous dans
% l'emploi du temps

for j=1:c
  for k=1:d*t
    for u=1:(mod(k,t)-1)
      for v=1:(t - mod(k,t))
        if (~(mod(k,t)==0 || mod(k,t)==1))
            L =[k-u , k+v , k];
            A(begin_ineq, twoD2oneD(j,k)) = -1;
		    for i=1:m
                A(begin_ineq, threeD2oneD(i,j,L)) = [ 1 , 1 , -1];
            end
             	b(begin_ineq,1) = 1;
                begin_ineq = begin_ineq + 1;
        else
            for i=1:m
                f(threeD2oneD(i,j,k),1)=1;
            end
        end
      end
    end
  end
end


% Plusieurs professeurs ne peuvent pas donner cours sur un même créneau

for j=1:c
    for k=1:d*t
      A(begin_ineq, threeD2oneD(I,j,k))=ones(1,m);
      b(begin_ineq)=1;
      begin_ineq=begin_ineq+1;
    end
end
 


X = intlinprog(f,1:length_X,A,b,Aeq,beq,lb,ub);

disp('The result is:---------------------------------------------------------------------------------------------------')
disp('The result is:-----------------------------------------------------------------')
%length(find(X(find(0.9<=X))<=1.1))
length(find(0.5<=X(length_x+1:length_X)))
X(find(0.5<=X))=1;



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

%AffichagePromo1;
fct_affichage( Promo1,d,t );
figure();
% AffichagePromo2;
fct_affichage( Promo2,d,t );
end