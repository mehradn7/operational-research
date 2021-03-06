function [ v ] = fct_affichage( Promo1,d,t )
%PROMO 1
% x est la solution optimale
% d jours par semaine et t créneaux par jour
% on représente un créneau par un rectangle de 1 sur 2
% L'emploi du temps est contenu dans le rectangle ([0;0], [0,d*2],
% [t,d*2],[t,0])
% 

%on définit la fenêtre
    j=0:d*2;
    h=0:t;
    grid('on');
    axis([0 d*2 0 t]);
    
    set(gca,'Xtick',0:2:d*2);  set(gca,'Ytick',0:1:t);  
    title('EDT');
    xlabel('jour'); ylabel('heure');

    %On définit les créneaux sous forme de rectangle (blanc par défaut, en
    %couleur si occupé)
    %creneau = zeros(d,t);
    for i= 1:d
        for j= 1:t
          creneau (i,j) = rectangle ('Position',[2*(i-1) t-j 2 1]);
          creneau(i,j).FaceColor='white'
        end
    end
    
    for i=1:d
        for j=1:t
            if Promo1(j,i) == 1
                creneau(i,j).FaceColor='red'
                text(2*(i-1)+0.2, t-j+0.5, 'Droite Maths');
            end
            if Promo1(j,i) == 2
                creneau(i,j).FaceColor='magenta';
                text(2*(i-1)+0.2, t-j+0.5, 'Ellips Maths');
            end
            if Promo1(j,i) ==3
                creneau(i,j).FaceColor='yellow';
                text(2*(i-1)+0.1, t-j+0.5, 'Proton Physique');
            end
            if Promo1(j,i) == 4
                creneau(i,j).FaceColor='green';
                text(2*(i-1)+0.2, t-j+0.5, 'Pascal Info');
            end
            if Promo1(j,i) ==5
                creneau(i,j).FaceColor='cyan';
                text(2*(i-1)+0.2, t-j+0.5, 'Dell Info');
            end
            if Promo1(j,i) ==6
                creneau(i,j).FaceColor='blue';
                text(2*(i-1)+0.2, t-j+0.5, 'Young Anglais');
            end
            if Promo1(j,i) ==7
                creneau(i,j).FaceColor=[0.5 0.2 0.75];
                text(2*(i-1)+0.2, t-j+0.5, 'Gazelle Sport');
            end
            if Promo1(j,i) ==8
                creneau(i,j).FaceColor=[1 0.7 0];
                text(2*(i-1)+0.2, t-j+0.5, 'Bigceps Sport');
            end
        end
    end
    v=1;
end

