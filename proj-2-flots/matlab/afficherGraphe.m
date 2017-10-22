function afficherGraphe(G)

for i=1:size(G,1)
    for j=1+(i-1):size(G,1)
        if (G(i,j) > 0)
            disp(sprintf('%d -- (%d/%d) --> %d\n',i,G(i,j),G(j,i),j))
        end
        if (G(i,j) < 0)
          
           disp(sprintf('%d -- (%d/%d) --> %d\n',j,-G(i,j),G(j,i),i))
        end
    end
end
end