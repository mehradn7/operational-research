% Projet n°4 -- Gestion des Stocks
function G =calcul_gain(s,D,S) 
%S = 10; %stock maximal
%s = M; %limite de réapprovisionement

% % Création de la loi normale
% N = 20;
% 
% % vecteur D contenant les alphak
% D=[];
% %  for i=1:S
% %          D = [D rand()];
% %  end
% %D = (1/1452)*ones(1,N);
% 
% % vecteur D contenant les alphak de alpha0 à alpha_S-1
% 
% 
% %D = poisspdf(1:N,3);
% 
% 
% %D = normpdf(rand(1,N),1);
% % D=binornd(1:N,0.7);
% % d=sum(D);
% % D=D/d;
% disp('Lois possibles : uniforme/normale/poisson/binomiale/geometrique');
% string=input('Choisir une loi: ','s');
% D = init_Loi(string,N);
% % Somme pour k allant de s a +infini de alphak
% S=5;
% s=3;
% D=[0.1 0.2 0.2 0.2 0.1 0.1 0.1 0 0 0 0 0 0];
somme_proba = 1 - sum(D(1:S));

% La matrice de transition P
P = zeros(S+1,S+1);

% on remplit la première ligne
P(1,1) = somme_proba;
for i=2:S+1
    P(1,i) = D(S-i+2);
end

% On copie la première ligne dans 2,3...s lignes
for i=2:s
    P(i,:) = P(1,:);
end
%On peut aussi rempli la dernière ligne qui est identique à la première
P(S+1,:) = P(1,:);

%Il reste à remplir de (s+1) à (S) lignes
ligne_courante = P(S+1,:);
for i=S:-1:s+1
    P(i,1) = ligne_courante(1) + ligne_courante(2);
    P(i,2:i) = ligne_courante(3:i+1);
    ligne_courante = P(i,:);
end

%[V,D]=eig(P');
% 

b=zeros(S+2,1);
b(S+2,1)=1;
Ptmp1=eye(S+1,S+1)-P;
Ptmp2 = [Ptmp1';ones(1,S+1)]; 
Pi=Ptmp2\b;


C1=5;
C2=10;
C3=10;
C4=5;
v=20;

G = Gain( Pi,D, C1, C2, C3, C4, s , S, v);
end


