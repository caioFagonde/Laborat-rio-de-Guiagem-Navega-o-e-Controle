classdef Earth < CelestialBody
    properties
        J2 = 1082.63E-6;
    end
   methods 
       function obj = Earth()

        % parameters   
        mass_t = 5.9722e+24; % kg
        radius_t = 6378; % km
        mu_t = 3.986004418e+5; % km^3/s^2
        rotvel = 7.292115e-5; % rad/s

        % creating and setting object properties
        obj = obj@CelestialBody(mass_t,radius_t,mu_t);   
        set(obj,'harmonicC','Earth_HC.txt');
        set(obj,'RotVel',rotvel);
        set(obj,'JPLID','399'); % set ID for use with JPL's Horizons system
        set(obj,'TextureFile','Earth.jpg')
        set(obj,'polarRadius',6356.752)
        % atomspheric properties
        set(obj,'LapseRate',9.760e-3);
        set(obj,'densityAtRef',1.217);
        set(obj,'StandardTemp',288);
        set(obj,'referenceHeight',0);
        set(obj,'AtmosMolarMass',28.97e-3);
        set(obj,'g0',9.798);
        set(obj,'name',"Earth");
        

        end
        
        
    end
end