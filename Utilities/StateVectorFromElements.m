function [R,V] = StateVectorFromElements(RA,TA,AP,i,e,a, mu)
% From Curtis Orbital Mechanics
%close all
%mu = 4*(pi^2);
h = sqrt(mu*a*(1-e^2));


% Precisamos usar DCMs

Re1 = [cos(RA) sin(RA) 0;-sin(RA) cos(RA) 0;0 0 1];
Re2 = [1 0 0;0 cos(i) sin(i);0 -sin(i) cos(i)];
Re3 = [cos(AP) sin(AP) 0;-sin(AP) cos(AP) 0;0 0 1];
M = inv(Re3*Re2*Re1); % inverse transform matrix
% esta DCM permite mudar do plano equatorial para o
% plano perifocal e vice-versa
r = a*(1-e^2)/(1+e*cos(TA));
vp = (mu/h)*(-sin(TA)*[1;0;0] + (e + cos(TA))*[0;1;0]);
rp = [r*cos(TA); r*sin(TA);0];
Rvec = M*rp;
v = M*vp;
R = Rvec;
V = v;
% De acordo com os exemplos do Curtis, está correto!
