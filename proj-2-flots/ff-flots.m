% Algorithme de ford et fulkerson pour les flots

% Triangle inférieur de G => capacité des arrêtes de i->j
% si G(i,j) = 0 : aucune arrête entre i et j
% si G(i,j) > 0 : une arrête de capacité G(i,j) relie i->j
% si G(i,j) < 0 : une arrête de capacité -G(i,j) relie j->i
G = [
% 0 1  2 3 4 5  i/j
  0 0  0 0 0 0; % 0
  8 0  0 0 0 0; % 1
  0 4  0 0 0 0; % 2
  6 0  0 0 0 0; % 3
  0 8 -2 6 0 0; % 4
  0 0  6 0 8 0; % 5
    ];
