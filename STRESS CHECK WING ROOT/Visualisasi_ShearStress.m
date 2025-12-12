hold on

%gambar panah
P1 = [w.point1];P2 = [w.point2];
X = [P1.x];
Y = [P1.y];
u = ([P2.x] - [P1.x])/2;
v = ([P2.y] - [P1.y])/2;
for i = 1:length(w)
   if w(i).q < 0
       P2X = [P2.x];
       P2Y = [P2.y];
       X(i) = P2X(i);
       Y(i) = P2Y(i);
       u(i) = -u(i);
       v(i) = -v(i);
   end
end
quiver(X,Y,u,v,0) 

%gambar struktur
for i=1:length(p) %untuk point
    p(i).plot();
end
for i=1:length(w) %untuk wall
    w(i).plot();
end
axis equal
grid on

for i = 1:length(w)
    plotText(w(i),num2str(w(i).tau,'%.0f'));
end

title('Shear Stress (MPa)');
