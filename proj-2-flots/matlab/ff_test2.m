G= zeros(8,8);

G = ajouterArc(G,1,2,10);   % 1
G = ajouterArc(G,1,3,5); % 2
G = ajouterArc(G,1,4,15);
G = ajouterArc(G,2,3,4);   % 3
G = ajouterArc(G,2,6,15);   % 4
G = ajouterArc(G,2,5,9);    % 5
G = ajouterArc(G,3,6,8);% 6
G = ajouterArc(G,3,4,4);
G = ajouterArc(G,4,7,16);    % 7
G = ajouterArc(G,5,6,15);    % 8
G = ajouterArc(G,5,8,10);% 9
G = ajouterArc(G,6,7,15)
G = ajouterArc(G,6,8,10);
G = ajouterArc(G,7,3,6);
G = ajouterArc(G,7,8,10);
% FIN DEFINITION DU GRAPHE
disp('Graphe initiale')
G


G = ff_flots(G,1,8);