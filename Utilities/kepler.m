function dydt = kepler(t,y,mu)

% Esta função simples calcula a derivada do estado no caso do problema de
% dois corpos

% ------------------
r = y(1:3); % posição
v = y(4:6); % velocidade

a = - mu * (r)/(norm(r)^3);

dydt = [v;a];
end
