classdef Material
    properties
        name string
        E(1,1) double %modulus young dalam GPa
        G(1,1) double %shear modulus dalam GPa
        sigmaY(1,1) double %yield strength dalam MPa
        rho(1,1) double %dalam kg/m^3
    end
    methods
        function obj = Material(name,E,G,sigmaY,rho)
            obj.name = name;
            obj.E = E;
            obj.G = G;
            obj.sigmaY = sigmaY;
            obj.rho = rho;
        end
              
    end
end