% NSUC = uint16([3 0 3 1 2 3 2 2]);
% 
% %
% % Vecteur des successeurs de chaque sommet : SUC
% SUC = uint16([2 3 4 4 5 6 8 6 7 4 7 8 5 2 7 2]);
% %
% % Vecteur des longueurs de chaque arc
% LONGinv = [inf 1 2 5 3 3 2 0 3 1 3 7 2 1 2 4];
% [m,v]=FFtension_init(NSUC, SUC, LONGinv)


% NSUC2 = uint16([4 0 1 3 2 2 3 2 1 1 1]);
% 
% %
% % Vecteur des successeurs de chaque sommet : SUC
% SUC2 = uint16([2 3 4 5 6 6 7 8 8 10 9 11 9 10 11 9 11 2 2 2]);
% %
% % Vecteur des longueurs de chaque arc
% LONGinv2 = [inf 5 0 3 16 14 14 14 20 10 8 8 18 18 18 25 25 15 17 10];
% 
% [m,v]=FFtension_init(NSUC2, SUC2, LONGinv2)

SUC=[3,0,1,1];
NSUC=[2,3,4,2,2];
LONG=[inf,5,1,6,2];
[m,v]=FFtension_init(NSUC, SUC, LONG)
