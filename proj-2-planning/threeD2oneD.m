function i_x = threeD2oneD(i_m,j_m,k_m)
p = 8; % teachers
d = 5; % days
t = 4; % slots/days
i_x = (i_m-1)*p*d*t + (j_m-1)*d*t + k_m;
