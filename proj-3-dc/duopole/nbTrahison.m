function nbTra = nbTrahison(numpart, tx, ty)
    indCoop = find(tx == 0.75);
    nbTra = length(find(ty(indCoop) ~= 0.75));
end
