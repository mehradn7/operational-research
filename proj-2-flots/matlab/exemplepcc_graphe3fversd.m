%% Initialisations
NSUC = uint16([3 3 4 2 1 1 3 0]);

sommet_depart = 6;
sommet_arrivee = 4;

%% Vecteur des successeurs de chaque sommet : SUC
SUC = uint16([2 7 8 3 6 8 2 4 5 6 3 5 3 1 2 6 8]);
%
% Vecteur des longueurs de chaque arc
LONG = [3 2 1 5 3 0 4 3 2 2 7 5 1 4 6 1 5];

[PLUSCOURTCHEMIN,longueur] = FFtensionPlusCourtChemin(NSUC, SUC, LONG, sommet_depart, sommet_arrivee);

disp (['Plus court chemin : ',num2str(PLUSCOURTCHEMIN)]);
disp (['Longueur du plus court chemin : ', num2str(longueur)]);

