function x = contreSameCoup(y)
    delta = 4*y*(y-3) - 9;
    if delta <= 0
        x = 1.5;
    else
        x1 = 1.5 - 0.5*sqrt(delta);
        x2 = 1.5 + 0.5*sqrt(delta);
        % on maximise -fE(x) sur [x1,x2]
        c = (y-3)/2;
        if (x1 <= c && c <= x2)
            x = c;
        elseif (c<x1)
            x = x1;
        else
            x = x2;
        end

    end
end
