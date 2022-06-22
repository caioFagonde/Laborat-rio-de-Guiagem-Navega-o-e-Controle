function oe = ElementsFromStateVector(R,V,mu)

I = [1 0 0];
J = [0 1 0];
K = [0 0 1];
h = cross(R,V);
%% Inclination
i = acos(h(3)/norm(h));

%% Line of Ascending Node
N = cross(K,h);

%% Right Ascension of Ascending Node
RA = [];
if norm(N) == 0
    RA = 0;
else
RA = acos(dot(N,I)/norm(N));
end

%% Excentricidade
E = (1/mu)*(cross(V,h) - (mu/norm(R))*R);
e = norm(E);

%% Argumento de Periapsis
AP = 0;
if e ~= 0
    AP = acos(dot(E,N)/(e*norm(N)));
end

%% Semieixo maior
a = (norm(h)^2/mu)/(1-e^2);

%% Anomalia verdadeira

TA = acos(dot(R,E)/(norm(R)*e));
if dot(R,E)/(norm(R)*e) == 1
    TA = 0;
end
if isnan(TA) || ~isreal(TA)
    TA = acos(dot(R,N)/(norm(R)*norm(N)));
end
if dot(V,R) < 0
    TA = 2*pi - TA;
end

%fprintf("A anomalia verdadeira é de %.1f deg\n",(AP*180/pi));
oe = [a,e,i,RA,AP,TA];

end





