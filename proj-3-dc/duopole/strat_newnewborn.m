function x = strategie(numpart,tx,ty,gx,gy)
% strategie -- Strategie d'un joueur 
%
%  Usage
%    x = strategie(numpart,tx,ty,gx,gy)
%
%  Inputs
%    tx     tableau des strategies jouees par le joueur x
%    ty     tableau des strategies jouees par le joueur y (l'adversaire)
%    gx     tableau des gains du joueur x
%    gy     tableau des gains du joueur y (l'adversaire)
%
%  Outputs
%    x      strategie elaboree par le joueur x
%
%  Description
%    Elaboration d'une strategie dans le cadre de jeux iteres
%    avec information complete. L'ensemble des strategies est
%
%  See also
%    jeu
%
%  References
%    "L'altruisme perfectionne", 


if (numpart == 2)
    s = 0.75;
else
    % nb_trahison =
    if(ty(numpart-1) == 0.75) % && nb_trahison < 3
        %compter nbtr- tout doux
        s = 0.75;
    else
        %identif strat vide
        if (sum(ty(1:numpart)) == 0)
            s = 1.5;
        end
        %identif affine
        tableauDonnees = [ty(numpart-3: numpart-1);tx(numpart-4: numpart-2)];
        tableauDonnees = unique(tableauDonnees','rows')';
        coef = tableauDonnees(1,1)/(3-tableauDonnees(2,1));
        eps = 1e-10;
        utiliseAntiAffine = norm(tableauDonnees(1,:)-coef*(3-tableauDonnees(2,:))) < eps && length(tableauDonnees(1,:))>1 && coef<1 && coef>0;
        if utiliseAntiAffine
        s = (3-ty(numpart-1))/(2-coef);
        else
        s = strat_keran2(numpart,tx,ty,gx,gy);
        end;
        %strat humaine
        
        %punir trahison
        s = 1.5;
        %valeurPrevue
        
        %faire croire qu'on est affine pour le fock
        
    end
end

if (numpart >= 3)
    if(ty(2) == 0.00001)
        s = 1.500001;
    else
        null;
    end
end

x = s;
    
    
    
    
    
    
