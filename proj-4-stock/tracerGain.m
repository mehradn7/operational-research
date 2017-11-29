
V_MAX = 200;
N=500;
disp('Lois possibles : uniforme/normale/poisson/binomiale/geometrique');
string=input('Choisir une loi: ','s');
D = init_Loi(string,N)
Z=[];
for S=1:V_MAX
    S
    G=zeros(1,V_MAX);
    for s=1:S
        G(s)=calcul_gain(s,D,S);
    end
    Z=[Z;G];
end


[max_val,idx]=max(Z(:))
[row,col]=ind2sub(size(Z),idx)


[X,Y] = meshgrid(1:V_MAX,1:V_MAX);
fig = figure;
surf(X,Y,Z);
xlabel('s');
zlabel('gain');
ylabel('S');
legend('Gain en fonction de s et S');


fig

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Résolution du problème
