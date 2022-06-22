classdef CelestialBody < matlab.mixin.Heterogeneous & matlab.mixin.SetGet
    properties
      mass
      radius
      polarRadius
      mu
      harmonicC
      JPLID
      TextureFile
      RotVel
      hasAtmos
      BodyFixedFrame
      InertialFrame
      % atmospheric properties
      LapseRate;
      densityAtRef;
      StandardTemp;
      referenceHeight;
      AtmosMolarMass;
      g0;
      name;
      scaleHeight;
   end
    methods  
        function obj = CelestialBody(varargin)
            varargin = cell2mat(varargin(1:3));
            if nargin == 0
                obj.mass = 0;
                obj.radius = 0;
                obj.mu = 0;
            elseif nargin == 1
                    obj.mass = varargin(1);
                    obj.radius = 0;
                    obj.mu = 0;
            elseif nargin == 2
                    obj.mass = varargin(1);
                    obj.radius = varargin(2);
                    obj.mu = 0;
            elseif nargin == 3
                    obj.mass = varargin(1);
                    obj.radius = varargin(2);
                    obj.mu = varargin(3);
            else
                throw(exception)
            end
        end
        function acc = GetGravAcceleration(varargin)
            if nargin == 1
                r = cell2mat(varargin(1));
               acc = obj.mu*r/norm(r)^3;
            elseif nargin == 2
                instance = varargin{1};
                r = cell2mat(varargin(2));
                acc = instance.mu*r/norm(r)^3;
            end
        end
        function [C,S] = GetHarmonicCoefficients(varargin)
            body = varargin{1};
            nZ= varargin{2};
            mT= varargin{3}; 
            fileName = string(body.harmonicC);
            fid = fopen(fileName,'r');
%             fileH = load(fileName);
            Cnm = zeros(nZ+1,mT+1);
            Snm = zeros(nZ+1,mT+1);
            cont = 1;
            for i=0:nZ
                for k=0:i
%                     coeff = fileH(cont,:);
                    coeff = fscanf(fid,'%f %f %f %f',[4 1]);
                    del = 2;
                    if k == 0
                        del = 1;
                    end
                    Norm_Factor = sqrt(factorial(i+k)/(del*(2*i+1)*factorial(i-k))); % coefficient normalization factor
                    
                    Cnm(i+1,k+1) = coeff(3)/Norm_Factor;
                    Snm(i+1,k+1) = coeff(4)/Norm_Factor;
                    cont = cont+1;
                end
            end
            C = Cnm;
            S = Snm;
        end
        function rho = EstimateDensityAtAltitude(obj,h)
            %% This is merely an approximation using the barometric formula
            Lb = obj.LapseRate;
            rhob = obj.densityAtRef;
            Tb = obj.StandardTemp;
            hb = obj.referenceHeight;
            Ma = obj.AtmosMolarMass;
            R = AstroConstants.R_gas;
            kb = AstroConstants.kb;

            H = (R*Tb)/(Ma*obj.g0);
%             if Lb ~= 0
%                 rho = rhob*(Tb/(Tb + Lb*(h - hb)))^(1 + obj.g0*Ma/(R*Lb));
%             else
%                 rho = rhob*exp(-obj.g0 * Ma * (h - hb)/(R*Tb));
%             end
            rho = rhob*exp(-(h-hb)/H);
        end
        
    end
end