 classdef Loop
    properties
        points Point
        walls Wall
        area(1,1) double % dalam m^2
        dir double % direction +1 searah, -1 berlawanan arah
    end
    methods
        function obj = Loop(angka,p,w)
            obj.points = p(angka);
            obj.area = polyarea([obj.points.x],[obj.points.y]);
            for i = 1:length(obj.points)-1
                obj.walls(i) = findW(w,p(angka(i)),p(angka(i+1)));
                if obj.walls(i).point1 == p(angka(i))
                    obj.dir(i) = 1;
                else
                    obj.dir(i) = -1;
                end
            end
            obj.walls(length(obj.points)) = findW(w,p(angka(length(obj.points))),p(angka(1)));
            if obj.walls(length(obj.points)).point1 == p(angka(length(obj.points)))
                obj.dir(length(obj.points)) = 1;
            else
                obj.dir(length(obj.points)) = -1;
            end
        end
        function plot(obj)
            line([obj.points.x],[obj.points.y]);          
        end
        %{
        
        function r = multiplyBy(obj,n)
            r = [obj.Value] * n;
        end
        function r = plus(o1,o2)
            r = [o1.Value] + [o2.Value];
        end
        %}
        function tf = eq(p1,p2)
            if p1.points == p2.points
               tf = true;
            else
               tf = false;
            end
        end
    end
end