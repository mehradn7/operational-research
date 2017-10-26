NSUC = uint16([4 0 1 3 2 2 3 2 1 1 1]);

% Vecteur des successeurs de chaque sommet : SUC
SUC = uint16([2 3 4 5 6 6 7 8 8 10 9 11 9 10 11 9 11 2 2 2]);
%
% Vecteur des longueurs de chaque arc
LONGinv = [0 5 0 3 16 14 14 14 20 10 8 8 18 18 18 25 25 15 17 10];

theta = FFtension_ordonancement(NSUC, SUC, LONGinv)