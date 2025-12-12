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
    if isnan(w(i).sigma) ~= true
        plotText(w(i),num2str(w(i).sigmaCrit,'%.0f'));
    end
end

title('Critical Normal Stress (skin + stiffener) (MPa)');
