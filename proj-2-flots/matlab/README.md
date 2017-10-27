# TESTS SUR LES FLOTS
Les fichiers de tests pour les flots suivant différents graphes sont :
    * ff_test0.m
	* ff_test1.m
	* ff_test2.m
	* exemple_flot_max_20.m
	* trafic_maritime.m : graphe du sujet !!!

# TESTS SUR LE PLUS COURT CHEMIN
	* exemplepcc_graphe*.m

# PLUS COURT CHEMIN 

Notre fonction FFtensionPlusCourtChemin prend en entrée 5 arguments : nsuc,
suc, long, sommet_depart et sommet_arrivee. nsuc est un vecteur ligne 
contenant le nombre des successeurs de chaque sommet (nsuc(i) contient le 
nombre de successeurs du sommet i). suc est un vecteur ligne contenant les 
successeurs de chaque sommet. long est un vecteur ligne contenant la 
longueur de chacun des arcs. sommet_depart indique le sommet duquel nous 
souhaitons partir et somme_arrivee indique le sommet auquel nous souhaitons 
arriver.
Afin que notre fonction donne un résultat correct, il est nécessaire que le
graphe donné comporte un chemin allant de sommet_depart à sommet_arrivee.

Notre fonction renvoie 2 éléments, un vecteur ligne contenant la liste des 
chemins parcourus ainsi qu'un entier désignant la longueur du chemin 
parcouru.


# FONCTIONS AUXILIAIRES

	* capacite.m renvoie pour un graphe G, la capacité entre les sommets i et j
	* flot.m renvoie pour un graphe G, le flot entre les sommet i et j
	* maj_flot.m fait la somme des flots dans le graphe G avec le tableau flot_aux
	* ajouterArc.m fonction qui rajoute l'arc (i,j) de capacité capa dans le
	  graphe G
	* afficherGraphe.m fonction qui affiche le flot dans le graphe
	* voisins_dir.m fonction qui renvoie le tableau des voisins directes du sommet
	  i dans le graphe G	
	* voisins_ind.m fonction qui renvoie le tableau des voisins indirectes du sommet
	  i dans le graphe G	
