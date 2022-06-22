classdef AstroConstants
   properties (Constant)
   deg = pi/180; % rad2deg conversion factor
   c = 2.99792458e+5;     % km/s
   G = 6.67259e-11        % m/kgs
   AU = 1.496e+8;
   J2000JD = 2451545.0; % Julian date corresponding to January 1st, 2000.
   EarthRotVel = 7.292115e-5; % rad/s 
   BodiesInPE = ["Sun","Mercury","Venus","Earth","Moon","Mars","Jupiter",...
       "Saturn","Uranus","Neptune","Pluto"]; % celestial bodies for third-body perturbations
   R_gas = 8.3144598; % universal gas constant N*m/(mol*K);
   albedo_t0JD = 2444960.5; % base epoch for albedo calculations (Vallado)
   kb = 1.380649e-23; % Boltzmann constant 
   end
end

