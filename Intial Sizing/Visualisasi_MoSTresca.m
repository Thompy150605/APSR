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

%gambar tulisan
for i = 1:length(w)
    MoSText = plotText(w(i),num2str(w(i).MoSTresca,'%.2f'));
    if w(i).MoSTresca < 0
        MoSText.Color = 'red';
    end
end

title('Margin of Safety Von Mises Criterion');
