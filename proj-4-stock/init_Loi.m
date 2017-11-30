% Calcul la capacité de l'arrète reliant le sommet i et j du graphe G
function D = init_Loi(string,N)
    D=zeros(1,N);
    switch string
        case 'uniforme'
             a=input('Entrer le parametre: ');
             D=(1/a)*ones(1,N);
        case 'normale'
            m=input('Entrer m: ');
            sigma=input('Entrer sigma: ');
            D = normpdf(0:N-1,m,sigma);
        case 'poisson'
            lambda=input('Entrer lambda: ');
            D = poisspdf(0:N-1,lambda);
        case 'binomiale'
            p=input('Entrer p: ');
            D=binornd(1:N,p);
%         case 'geometrique'
%             N=input('Entrer N');
%             N=input('Entrer N');
    end
    d=sum(D);
    D=D/d;
end
