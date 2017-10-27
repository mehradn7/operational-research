
%% Initialisations
NSUC = uint16([2 3 1 2 0]);

sommet_depart = 1;
sommet_arrivee = 5;

%% Vecteur des successeurs de chaque sommet : SUC
SUC = uint16([2 4 3 4 5 5 3 5]);
%
% Vecteur des longueurs de chaque arc
LONG = [1 2 3 3 12 4 0 5];

[PLUSCOURTCHEMIN,longueur] = FFtensionPlusCourtChemin(NSUC, SUC, LONG, sommet_depart, sommet_arrivee);

disp (['Plus court chemin : ',num2str(PLUSCOURTCHEMIN)]);
disp (['Longueur du plus court chemin : ', num2str(longueur)]);
