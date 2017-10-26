
%% Initialisations
NSUC = uint16([3 0 3 1 2 3 2 2]);

sommet_depart = 2;
sommet_arrivee = 1;

%% Vecteur des successeurs de chaque sommet : SUC
SUC = uint16([2 3 4 4 5 6 8 6 7 4 7 8 5 2 7 2]);
%
% Vecteur des longueurs de chaque arc
LONG = [inf 1 2 5 3 3 2 0 3 1 3 7 2 1 2 4];

[PLUSCOURTCHEMIN,longueur] = FFtensionPlusCourtChemin(NSUC, SUC, LONG, sommet_depart, sommet_arrivee);

disp (['Plus court chemin : ',num2str(PLUSCOURTCHEMIN)]);
disp (['Longueur du plus court chemin : ', num2str(longueur)]);

