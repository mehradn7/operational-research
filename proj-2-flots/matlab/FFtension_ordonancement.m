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
function theta = FFtension ordonnancement(NSUC, SUC, 
NSUC = uint16([3 0 3 1 2 3 1 2]);
n = size(NSUC,2);
X = uint16(1:n); % X contient la liste des sommets de G
m = sum(NSUC);
%
% Vecteur des successeurs de chaque sommet : SUC
SUC = uint16([2 3 4 4 5 6 8 6 7 4 7 8 2 7 2]);
%
% Vecteur des longueurs de chaque arc
LONG = [0 1 2 5 3 3 2 0 12 1 3 9 1 2 4];
Tension = zeros(1,m);
%
% Vecteur de la tension courante theta
theta = LONG;
%
MARQUE = false(1,n); % MARQUE est un vecteur logique
MARQUE(1) = true; % on marque le premier sommet 
%
NONMARQUES = X(~MARQUE); % NONMARQUES contient la liste des sommets non marqués
%
PLUSCOURTCHEMIN = uint16(zeros(1,n)); % Vecteur du plus court chemin de 1 (b) à 2 (a)
PLUSCOURTCHEMIN(1) = 1;
%
%% Algorithme de FF
while ismember(2,NONMARQUES) % Tant que b == 1 non marqué
    CANDIDATS = false(1,n); % CANDIDATS est un vecteur logique contenant les candidats à
    % être marqués
    %
    %% 1.   MAJ tension courante theta
    beta = 0;     % changement ici b = inf
    vcocycle = zeros(1,m); % vecteur cocycle des sommets non marqués
    for l=1:size(NONMARQUES,2)
        i = NONMARQUES(l); % i est non marqué
        if NSUC(i) ~= 0 % le nombre de successeurs de i est non nul
            prsuc = sum(NSUC(1:i-1)) + 1; % prsuc contient l'indice du 1er successeur de i dans SUC
            for k = prsuc:prsuc+NSUC(i)-1
                j = SUC(k); % (i,j) est un arc
                if MARQUE(j)
                    % j est un sommet marqué (et i est nonmarqué donc (i,j)
                    % appartient au cocycle
                    % donc i est candidat à être marqué
                    CANDIDATS(i) = true;
                    beta = max(beta,LONG(k) - theta(k)); % beta > 0
                    vcocycle(k) = 1;
                end
            end
        end
    end
    theta = theta + beta*vcocycle; %MAJ theta
    %
    %% 2.   Marquer sommets
    liste_candidats_marquage = X(CANDIDATS);
    for l=1:size(liste_candidats_marquage,2)
        i = liste_candidats_marquage(l); % i est non marqué et candidat à être marqué
        if NSUC(i) ~= 0
            % le nombre de successeurs de i est non nul
            prsuc = sum(NSUC(1:i-1)) + 1; % prsuc contient l'indice du 1er successeur de i dans SUC
            for k = prsuc:prsuc+NSUC(i)-1
                j = SUC(k); % j est successeur du sommet i candidat au marquage
                if MARQUE(j) && theta(k) == LONG(k)
                    % i est non marqué , j est marqué, (i,j) est un arc (de numéro k) , et la
                    % valeur de la tension sur cet arc est égale à la longueur
                    % de l'arc (i,j)
                    % donc on marque i
                    MARQUE(i) = true; % on marque le sommet i
                    NONMARQUES = setdiff(NONMARQUES,i); % on enlève i des sommets non marqués
                end
            end
        end
    end
end
disp('=======================================')
%% 3. Post-traitement : extraction du plus court chemin
i = 1;
prsuc = 1;
nsom = 1;
while i ~= 2
    for k = prsuc:prsuc+NSUC(i)-1
        j = SUC(k);
        if theta(k) == LONG(k)
            nsom = nsom + 1;
            PLUSCOURTCHEMIN(nsom) = j;
            break;
        end
    end
    i=j;
    prsuc = sum(NSUC(1:i-1)) + 1;
end
%
disp (['Plus court chemin : ',num2str(PLUSCOURTCHEMIN(1:nsom))]);
disp (['Longueur du plus court chemin : ', num2str(theta(1))]);
