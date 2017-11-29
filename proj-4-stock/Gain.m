function G = Gain( Pi,D, C1, C2, C3, C4, s , S, v)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
G = 0;
sum1 = 0;
sum2 = 0;
for k=1:length(D)-S-1
    sum1 = sum1 + k*D(k+S+1);
end

for k=0:length(D)-1
    sum2 = sum2 + min(S,k)*D(k+1);
end


for i=0:s-1
    G= G + Pi(i+1)*(-C1*S-C2*sum1 -C3 -C4*(S-i) + v*sum2);
end

for j=s:S
    sum3 =0;
    sum4=0;
    for k=1:length(D)-1-j
        sum3 = sum3 + k*D(k+1+j);
    end
    for k=1:length(D)-1
        sum4 = sum4 + min(j,k)+D(k+1);
    end
    G = G + Pi(j+1)*(-C1*j-C2*sum3 + v*sum4);
end

end
