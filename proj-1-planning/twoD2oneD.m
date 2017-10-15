% == bijection between i_x <-> (k_m, l_m) ==
% i_x = p*c*d*t + (k_m-1)*d*t + l_m
% i_m = fix(i_x/(p*d*t)) + 1
% rest_i_m = mod(i_m, p*d*t)
% j_m = fix(rest_i_m/(d*t)) + 1
% k_m = mod(rest_i_m, d*t)
% == === === === ==
function i_x = twoD2oneD(k_m,l_m)
p = 8; % teachers
d = 5; % days
t = 4; % slots/days
c = 2; % promos
i_x = p*c*d*t + (k_m-1)*d*t + l_m;
