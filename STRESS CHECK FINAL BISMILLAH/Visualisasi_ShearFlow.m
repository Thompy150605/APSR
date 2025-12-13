hold on

%gambar panah
for j = 1 : length(c_section)
    P1 = [w(:,j).point1];P2 = [w(:,j).point2];
    X = [P1.x];
    Y = [P1.y];
    u = ([P2.x] - [P1.x])/2;
    v = ([P2.y] - [P1.y])/2;
    for i = 1:length(w)
       if w(i,j).q < 0
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
        w(i,j).plot();
    end
    axis equal
    grid on
    
    %gambar tulisan (yang di sini itu stress, bukan shear flow)
    for i = 1:length(w)
        plotText(w(i,j),num2str(abs(w(i,j).q/1000),'%.0f'));
    end
    
    title('Shear Flow (kN/m)');
end