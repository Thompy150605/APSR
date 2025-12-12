hold on

%gambar struktur
for i=1:length(p) %untuk point
    p(i).plot();
end
for i=1:length(w) %untuk wall
    w(i).plot();
end
axis equal
grid on

%gambar tulisan (yang di sini itu stress, bukan shear flow)
P1 = [w.point1];P2 = [w.point2];
X = [P1.x] + ([P2.x] - [P1.x])/2;
Y = [P1.y] + ([P2.y] - [P1.y])/2;
for i = 1:length(w)
    plotText(w(i),num2str(w(i).tauCrit,'%.0f'));
end

title('Critical Shear Stress (thin sheet) (MPa)');
