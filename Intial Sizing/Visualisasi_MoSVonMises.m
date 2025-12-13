hold on

% Gambar Struktur (Points & Walls)
for i=1:length(p) 
    p(i).plot();
end
for i=1:length(w) 
    w(i).plot();
end
axis equal
grid on

% Gambar Tulisan Nilai MoS Von Mises
for i = 1:length(w)
    % Plot angka MoS di tengah-tengah wall
    MoSText = plotText(w(i), num2str(w(i).MoSVonMises, '%.2f'));
    
    % Jika MoS < 0 (Fail), warnai merah
    if w(i).MoSVonMises < 0
        MoSText.Color = 'red';
        MoSText.FontWeight = 'bold';
    end
end

title('Margin of Safety: Von Mises Criterion');