classdef Point < handle
    properties
        name string
        x double %dalam m
        y double %dalam m
        area(1,1) double %dalam mm^2
        area2(1,1) double %idealisasi luas dalam mm^2 
        sigma(1,1) double %normal stress dalam MPa
        material Material
    end
    methods
        function obj = Point(n,pos,material,A)
            obj.name = n;
            obj.x = pos(1);
            obj.y = pos(2);
            obj.material = material;
            obj.area = A;
            obj.area2 = A;
        end
        function plot(obj)
            scatter(obj.x,obj.y,'filled','b','MarkerFaceColor','m');
        end
        function T = plotText(obj,t)
            T = text(obj.x,obj.y,t,'HorizontalAlignment','center');
        end
        %{
        function r = roundOff(obj)
            r = round([obj.Value],2);
        end
        function r = multiplyBy(obj,n)
            r = [obj.Value] * n;
        end
        
        %}
        function tf = eq(p1,p2)
            if p1.name == p2.name
               tf = true;
            else
               tf = false;
            end
        end
    end
end