% Deformation de trajectoire
%
p_aux = P(i).pp;
a_supp = p_aux(end);
p_aux(p_aux == a_supp) = [];
coll = diff(p_aux);
[~, col1] = find(coll == 0)
col1 = col1(1);
xcol = xy(1, round(p_aux(col1)), i)
ycol = xy(2, round(p_aux(col1)), i)
%