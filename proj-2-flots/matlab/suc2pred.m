% À partir de la structure d'un graph à partir des successeurs on génère
% une structure de graphe à partir des prédecesseurs.
% * NSUC : où NSUC(i) est le nombre de successeurs du sommet i
% * SUC : contient les sucesseurs
% * SLONG : contient le poid des arrêtes
function [NPRD,PRD,LONG] = suc2pred(NSUC,SUC,SLONG)

NPRD = zeros(size(NSUC));
PRD = zeros(1,sum(NSUC));
LONG = zeros(1,sum(NSUC));
i_nouveau = 0;

for s_courant=1:size(NSUC,2) %boucle sur les sommets
	for pred_poss=1:size(NSUC,2) %boucle sur les prédécesseurs possibles
		deb = sum(NSUC(1:pred_poss-1))+1;
		for i_succ=deb:deb+NSUC(pred_poss)-1
			if (SUC(i_succ)==s_courant)
                i_nouveau = i_nouveau+1;
				NPRD(s_courant) = NPRD(s_courant)+1;
				PRD(i_nouveau) = pred_poss;
                LONG(i_nouveau) = SLONG(i_succ);
			end
		end
end

end %function
