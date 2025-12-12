classdef Wall
    properties
        name string
        point1 Point
        point2 Point
        t(1,1) double %dalam mm
        length(1,1) double % dalam m
        area(1,1) double % dalam mm^2
        vector(1,3) double %vektor untuk penentuan arah
        q(1,1) double = NaN %shear flow dalam N/m
        tau(1,1) double = NaN %shear stress dalam MPa
        sigma double = NaN %normal stress dalam MPa (ambil dari titik dengan sigma terbesar)
        sigmaCrit(1,1) double = NaN %normal stress crit karena buckle
        tauCrit(1,1) double = NaN %shear stress crit karena buckles 
        MoSTresca(1,1) double = NaN %margin of safety Tresca Criterion
        MoSBuckle(1,1) double = NaN %margin of safety buckle
        material Material
    end
    methods
        function obj = Wall(n,p1,p2,material,t)
            obj.name = n;
            obj.point1 = p1;
            obj.point2 = p2;
            obj.material = material;
            obj.t = t;
            obj.length = sqrt((obj.point2.x - obj.point1.x)^2 +... 
            (obj.point2.y - obj.point1.y)^2);
            obj.area = obj.t*obj.length*1000;
            obj.vector = [(p2.x-p1.x) (p2.y-p1.y) 0];
        end
        
        function plot(obj)
            line([obj.point1.x obj.point2.x],[obj.point1.y obj.point2.y],'color','m');
        end
        function T = plotText(obj,t)
            X = (obj.point1.x + obj.point2.x)/2;
            Y = (obj.point1.y + obj.point2.y)/2;
            T = text(X,Y,t,'HorizontalAlignment','center');
        end
        %fungsi ini untuk hitung ulang luas kalau thickness atau panjang diedit
        function r = recalculateArea(obj)
            r = obj.t*obj.length*1000;
        end
        
        function tf = eq(p1,p2)
            if p1.name == p2.name
               tf = true;
            else
               tf = false;
            end
        end
    end
end