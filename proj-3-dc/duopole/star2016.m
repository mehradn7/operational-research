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
%   strategie pour contrer une strategie affine y(n) = b(d-x(n-1))

if (numpart == 1)
    % par defaut, on coopere
	x= 0.75;
else
    %on punit la trahison!!!
    if (ty(numpart-1)==0.75)
        x = 0.75;
    else
        x = strat_agressive(numpart,tx,ty,gx,gy);
    end
end;