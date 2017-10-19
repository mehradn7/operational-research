% Algorithme de ford et fulkerson pour les flots

% Triangle inférieur de G => capacité des arrêtes de i->j
% si G(i,j) = 0 : aucune arrête entre i et j
% si G(i,j) > 0 : une arrête de capacité G(i,j) relie i->j
% si G(i,j) < 0 : une arrête de capacité -G(i,j) relie j->i
% Trangle supérieur de G => Flot courant sur l'arrête i-j
% G(j,i) indique le flot courant sur l'arrête i-j
G = [
% 1 2 3 4  5 6  j/i
  X 8 0 6  0 0; % 1
  0 X 4 0  8 0; % 2
  0 0 X 0 -2 6; % 3
  0 0 0 X  6 0; % 4
  0 0 0 0  X 8; % 5
  0 0 0 0  0 X; % 6
    ];
