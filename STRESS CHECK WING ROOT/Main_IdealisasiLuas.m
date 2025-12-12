%hitung centroid y dalam m
Akaliy = 0;
for i=1:length(p) %untuk point
    Akaliy = Akaliy + p(i).area * p(i).y;
end
for i=1:length(w) %untuk wall
    Akaliy = Akaliy + w(i).area * (w(i).point1.y + w(i).point2.y)/2;
end
Atotal = sum([p.area]) + sum([w.area]);
ycd = Akaliy/Atotal;

%hitung centroid x dalam m
Akalix = 0;
for i=1:length(p) %untuk point
    Akalix = Akalix + p(i).area * p(i).x;
end
for i=1:length(w) %untuk wall
    Akalix = Akalix + w(i).area * (w(i).point1.x + w(i).point2.x)/2;
end
Atotal = sum([p.area]) + sum([w.area]);
xcd = Akalix/Atotal;

%idealisasi luas
for i=1:length(p)
    p(i).area2 = p(i).area;
    for j=1:length(w)
        if w(j).point1 == p(i)
            p(i).area2 = p(i).area2 + w(j).t*w(j).length*1000/6*(2+(w(j).point2.y-ycd)/(p(i).y-ycd));
        elseif w(j).point2 == p(i)
            p(i).area2 = p(i).area2 + w(j).t*w(j).length*1000/6*(2+(w(j).point1.y-ycd)/(p(i).y-ycd));
        end
    end
    
end

%hitung Iy = A*y^2 dalam m^4
Iy = 0;
for i=1:length(p)
    Iy = Iy + p(i).area2*10^-6*(p(i).y-ycd)^2;
end 
Ix = 0;
for i=1:length(p)
    Ix = Ix + p(i).area2*10^-6*(p(i).x-xcd)^2;
end 
Ixy = 0;
for i=1:length(p)
    Ixy = Ixy + p(i).area2*10^-6*(p(i).x-xcd)*(p(i).y-ycd);
end

%hitung K
Kyy = Ix/(Ix*Iy-Ixy^2);
Kxy = Ixy/(Ix*Iy-Ixy^2);

%output
fprintf('Centroid di y = %.3g m\n',ycd)
fprintf('Iy = %.4g m^4\n',Iy)

for i=1:length(p)
    %fprintf('Luas titik %s adalah %.2f mm^2\n',p(i).name,p(i).area2)
end

