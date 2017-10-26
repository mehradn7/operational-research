%% Algorithme de *Ford-Fulkerson* pour les tensions
%
% Application à la recherche du plus court chemin du sommet 1 (b) au sommet 2 (a)
% dans un graphe (X,U) modélisé comme un problème de tension maximale
%
% Representation du graphe
%
% n == nombre de sommets
%
% m == nombre d'arcs
%
% Vecteur du nombre de successeurs de chaque sommet : NSUC
%
% Vecteur des successeurs de chaque sommet : SUC
%
%% Initialisations
function theta = FFtension_ordonancement(NSUC, SUC, LONG)
%     NSUC = uint16([3 0 3 1 2 3 1 2]);
    n = size(NSUC,2);
    X = uint16(1:n); % X contient la liste des sommets de G
    m = sum(NSUC);
    %
    % Vecteur des successeurs de chaque sommet : SUC
%     SUC = uint16([2 3 4 4 5 6 8 6 7 4 7 8 2 7 2]);
    % Vecteur des predeccesseurs de chaque sommet : PRED
    [NPRED, PRED, LONG_PRED] = suc2pred(NSUC, SUC, LONG);

%     NPRED=NSUC;
%     PRED=SUC;
%     LONG_PRED=LONG;
%     
    % Vecteur des longueurs de chaque arc
%     LONG = [0 1 2 5 3 3 2 0 12 1 3 9 1 2 4];
    Potentiel = zeros(1,m);   % le potentiel en chaque sommet
    %
    % Vecteur de la tension courante theta
    theta = LONG_PRED;
    %
    MARQUE = false(1,n); % MARQUE est un vecteur logique
    MARQUE(1) = true; % on marque le premier sommet 
    %
    NONMARQUES = X(~MARQUE); % NONMARQUES contient la liste des sommets non marqués
    
    %
    %% Algorithme de FF
    while length(NONMARQUES) ~= 0  % Tant que b == 1 non marqué
        %
        %% 1.   MAJ tension courante theta
        for l=1:size(NONMARQUES,2)
            i = NONMARQUES(l); % i est non marqué
            if NPRED(i) ~= 0 % le nombre de successeurs de i est non nul
                prpred = sum(NPRED(1:i-1)) + 1; % prsuc contient l'indice du 1er prédecesseur de i
                tous_marque = 1;   % boolean false
                for k = prpred:prpred+NPRED(i)-1
                    j = PRED(k); % (i,j) est un arc
                    tous_marque = tous_marque && MARQUE(j);
                end
                if tous_marque
                   % on détermine le potentiel de i (max des potentiels possible)
                   potent_max = 0;
                   for k = prpred:prpred+NPRED(i)-1
                        j = PRED(k); % (i,j) est un arc
                        potent_max = max(potent_max, LONG_PRED(k) + Potentiel(j));
                   end
                   % on a le potentiel de i
                   Potentiel(i) = potent_max;
                   % on met a jour les tensions sur les arcs entrant
                   for k = prpred:prpred+NPRED(i)-1
                        theta(k) = Potentiel(i) - Potentiel(PRED(k));  % maj de theta
                   end
                   MARQUE(i) = true; % on marque le sommet i
                   NONMARQUES = setdiff(NONMARQUES,i) % on enlève i des sommets non marqués
                   break
                end
            end
        end        
    end
    Potentiel
end
