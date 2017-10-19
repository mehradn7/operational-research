# Pseudo code de l'algorithme de Ford-Fulkerson Flots

      Fonction flotMax(Graphe G, sommet s, sommet t) retourner flot

        //Initialisation

        flots_aux = tableau(nombre_arrêtes(graphe))
        capacité = tableau(nombre_arrêtes(graphe))
        flot = tableau_zeros(nombre_arrêtes(graphe))
        voisins_visité = liste() //liste vide
        voisin_visitables = pile(sommet_depart(G))

        // continuer = il existe un chemin améliorant de s à t
        Tantque (continuer) faire // parcourt des chemins
          flot_aux = tableau_zeros(nombre_arrêtes(graphe))
          beta = +inf
          sommet_courant = s
          Tantque (t non marqué) faire // construction des chemins
            
          fin tantquqe
          continuer =  not(flot_aux = [0,...0])
        fin tantque
