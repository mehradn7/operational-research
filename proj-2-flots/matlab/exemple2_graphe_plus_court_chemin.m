
%% Initialisations
NSUC = uint16([0 2 1 3 2 2 2 3]);

sommet_depart = 2;
sommet_arrivee = 1;

%% Vecteur des successeurs de chaque sommet : SUC
SUC = uint16([8 3 6 3 6 7 4 7 1 7 1 5 3 4 5]);
%
% Vecteur des longueurs de chaque arc
LONG = [1 2 2 1 7 3 0 3 4 2 1 2 5 3 3];

[PLUSCOURTCHEMIN,longueur] = FFtensionPlusCourtChemin(NSUC, SUC, LONG, sommet_depart, sommet_arrivee);

disp (['Plus court chemin : ',num2str(PLUSCOURTCHEMIN)]);
disp (['Longueur du plus court chemin : ', num2str(longueur)]);

