% == bijection between i_x <-> (i_m, j_m, k_m) ==
% i_x = (i_m-1)*p*d*t + (j_m-1)*d*t + k_m
% i_m = fix(i_x/(p*d*t)) + 1
% rest_i_m = mod(i_m, p*d*t)
% j_m = fix(rest_i_m/(d*t)) + 1
% k_m = mod(rest_i_m, d*t)
% == === === === ==
function i_x = threeD2oneD(i_m,j_m,k_m)
p = 8; % teachers
d = 5; % days
t = 4; % slots/days
i_x = (i_m-1)*p*d*t + (j_m-1)*d*t + k_m;
