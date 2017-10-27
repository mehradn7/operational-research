G= zeros(14,14);

G = ajouterArc(G,1,2,20);   % 1
G = ajouterArc(G,1,3,15);   % 2
G = ajouterArc(G,2,4,8);
G = ajouterArc(G,2,5,6);
G = ajouterArc(G,2,3,10);
G = ajouterArc(G,3,5,20);
G = ajouterArc(G,4,6,4);
G = ajouterArc(G,4,7,3);
G = ajouterArc(G,4,8,5);
G = ajouterArc(G,5,8,7);
G = ajouterArc(G,5,9,10);
G = ajouterArc(G,6,10,4);
G = ajouterArc(G,7,10,2);
G = ajouterArc(G,8,10,4);
G = ajouterArc(G,8,11,6);
G = ajouterArc(G,9,11,12);
G = ajouterArc(G,10,12,8);
G = ajouterArc(G,10,13,6);
G = ajouterArc(G,11,12,10);
G = ajouterArc(G,11,13,7);
G = ajouterArc(G,12,14,10);
G = ajouterArc(G,13,14,10);   

% FIN DEFINITION DU GRAPHE
disp('Graphe initiale')
G


G = ff_flots(G,1,14);
disp('Graphe avec le nouveau flot')
G

