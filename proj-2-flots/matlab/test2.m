G= zeros(6,6);

G = ajouterArc(G,1,2,10);   % 1
G = ajouterArc(G,1,3,10);   % 2
G = ajouterArc(G,2,3,2);   % 3
G = ajouterArc(G,2,4,4);   % 4
G = ajouterArc(G,2,5,8);    % 5
G = ajouterArc(G,3,5,9);    % 6
G = ajouterArc(G,4,6,10);    % 7
G = ajouterArc(G,5,4,6);    % 8
G = ajouterArc(G,5,6,10);    % 9

% FIN DEFINITION DU GRAPHE
disp('Graphe initiale')
G


G = ff_flots(G,1,6);