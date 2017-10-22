% DEFINITION DU GRAPHE
% 1 est la source.
% 10 est le puit.
% A -> 2
% B -> 3
% C -> 4
% D -> 5
% E -> 6
% F -> 7
% G -> 8
% H -> 9
G= zeros(10,10);

G = ajouterArc(G,1,2,10);
G = ajouterArc(G,1,3,20);
G = ajouterArc(G,1,4,10);
G = ajouterArc(G,1,5,10);
G = ajouterArc(G,3,2,3);
G = ajouterArc(G,3,4,5);
G = ajouterArc(G,5,4,4);
G = ajouterArc(G,2,6,8);
G = ajouterArc(G,2,7,4);
G = ajouterArc(G,3,6,5);
G = ajouterArc(G,3,7,7);
G = ajouterArc(G,3,8,3);
G = ajouterArc(G,4,7,6);
G = ajouterArc(G,4,8,1);
G = ajouterArc(G,4,9,7);
G = ajouterArc(G,5,8,5);
G = ajouterArc(G,5,9,2);
G = ajouterArc(G,6,7,2);
G = ajouterArc(G,8,7,3);
G = ajouterArc(G,8,9,5);
G = ajouterArc(G,6,10,10);
G = ajouterArc(G,7,10,10);
G = ajouterArc(G,8,10,20);
G = ajouterArc(G,9,10,10);
% FIN DEFINITION DU GRAPHE
G