function Problem1

%% ----------------------------------
% Laboratório de Guiagem, Navegação e Controle
% Professor: Antônio Gil Vicente de Brum
% Código para a resolução da primeira atividade
% Grupo:
%     Caio Nahuel Sousa Fagonde, 11201810070
%     Leonardo de Carvalho Chicarolli, RA 
%     Denise Seguchi Nakaie, RA 
% 
% Tópico: Órbitas keplerianas / Problema de dois corpos  
% Devemos simular uma órbita com as seguintes condições iniciais:
% State Vector = [R,V] = [-2.15587e+5, 2.98544e+5, 1.6736e+5, -8.06701e-1,
% -5.05134e-1, -1.88491e-1]'; [km ; km/s]

%% ------------------------------------

clear
close all

%% Definição do corpo central 
CentralBody = Earth();

%% Definição do parâmetro gravitacional da Terra (mu)
mu = CentralBody.mu; 
% Definição dos vetores de estado
R = [-2.15587e+5, 2.98544e+5, 1.6736e+5]'; % [km]
V = [-8.06701e-1,-5.05134e-1, -1.88491e-1]'; % [km/s]

% R = 1.0e+03*[-3.67454, 5.62545, 0.00432036]';
% V = [-3.86211, -2.52301, 6.16972]'; 

SV = [R;V];



%% Obtendo o período orbital
% Elementos Orbitais
oe = ElementsFromStateVector(R,V,mu);

a = oe(1); % semieixo maior
n0 = sqrt(mu/a^3); % movimento médio
T = 2*pi/n0; % Período orbital
tspan = linspace(0,4*T,2000);

%% Opções do integrador
options = odeset("AbsTol",1e-10,"RelTol",1e-10);

%% Integração numérica
[t,y] = ode45(@(t,y) kepler(t,y,mu), tspan, SV, options);
y_ecef = [];
% obtendo a órbita no referencial ECEF
for i = 1:length(t)
    ang = t(i)*CentralBody.RotVel;
    DCM = Rz_Matrix(ang);
    y_ecef(i,:) = (DCM*y(i,1:3)')';
end

%% Plotando os resultados
% Desenhando a Terra
figure
axes = gca;
title('Órbita inercial - sistema ECI')
planet = DrawPlanet(axes, CentralBody, [0,0,0],0);
hold on
plot3(y(:,1),y(:,2),y(:,3),'LineWidth',2,'Color','m')
xlabel("X (km)")
ylabel("Y (km)")
zlabel("Z (km)")

figure
axes = gca;
title('Órbita não-inercial - sistema ECEF')
planet = DrawPlanet(axes, CentralBody, [0,0,0],0);
hold on
plot3(y_ecef(:,1),y_ecef(:,2),y_ecef(:,3),'LineWidth',2,'Color','m')
xlabel("X (km)")
ylabel("Y (km)")
zlabel("Z (km)")





