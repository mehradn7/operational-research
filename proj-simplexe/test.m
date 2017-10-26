% Test de la fonction simplexe sur quelques exemples
% Exemple du brasseur
clear all

nbIt = 10000;

%%
brasseur;
disp('brasseur');
tic
for i=1:nbIt
    [x,F] = simplexe(OPT,c,A,b);
end
x
F
t1 = toc;
%%
disp('**********');
%%
concurrent;
disp('concurrent');
tic
for i=1:nbIt
    [x,F] = simplexe(OPT,c,A,b);
end
t2 = toc;
F
%%
disp('**********');
%%
Gass;
disp('Gass');
tic
for i=1:nbIt
    [x,F] = simplexe(OPT,c,A,b);
end
t3 = toc;
x
F
%%
disp('**********');
%%
exemple1;
disp('exemple 1');
tic
for i=1:nbIt
    [x,F] = simplexe(OPT,c,A,b);
end
t4 = toc;
x
F
%%
disp('**********');
%%
exemple2;
disp('exemple 2');
tic
for i=1:nbIt
    [x,F] = simplexe(OPT,c,A,b);
end
t5 = toc;
x
F
%%
disp('**********');
%%
exemple3;
disp('exemple 3');
tic
for i=1:nbIt
    [x,F] = simplexe(OPT,c,A,b);
end
t6 = toc;
x
F
%%
disp('**********');
%%
exemple4;
disp('exemple 4');
tic
for i=1:nbIt
    [x,F] = simplexe(OPT,c,A,b);
end
t7 = toc;
x
F
%%
disp('**********');
%%
exemple5;
disp('exemple 5');
tic
for i=1:nbIt
    [x,F] = simplexe(OPT,c,A,b);
end
t8 = toc;
x
F
disp(sprintf('Temps du brasseur : %f', t1));
disp(sprintf('Temps du concurrent : %f', t2));
disp(sprintf('Temps du Gass : %f', t3));
disp(sprintf('Temps de exemple1 : %f', t4));
disp(sprintf('Temps du exemple2 : %f', t5));
disp(sprintf('Temps du exemple3 : %f', t6));
disp(sprintf('Temps du exemple4 : %f', t7));
disp(sprintf('Temps du exemple5 : %f\n', t8));