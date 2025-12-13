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
for i = 1:length(w)
    plotText(w(i),num2str(abs(w(i).t),'%.2g'));
end

title('Wall Thickness (mm)');
