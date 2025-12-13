%hitung centroid y dalam m
for j = 1 : length(c_section)
    Akaliy = 0;
    for i=1:height(p(:,j)) %untuk point
        Akaliy = Akaliy + p(i,j).area * p(i,j).y;
    end
    for i=1:height(w(:,j)) %untuk wall
        Akaliy = Akaliy + w(i,j).area * (w(i,j).point1.y + w(i,j).point2.y)/2;
    end
    Atotal = sum([p(:,j).area]) + sum([w(:,j).area]);
    ycd(j) = Akaliy/Atotal;
    
    %hitung centroid x dalam m
    Akalix = 0;
    for i=1:height(p(:,j)) %untuk point
        Akalix = Akalix + p(i,j).area * p(i,j).x;
    end
    for i=1:height(w(:,j)) %untuk wall
        Akalix = Akalix + w(i,j).area * (w(i,j).point1.x + w(i,j).point2.x)/2;
    end
    Atotal = sum([p(:,j).area]) + sum([w(:,j).area]);
    xcd(j) = Akalix/Atotal;
    
    %idealisasi luas
    for i=1:height(p(:,j))
        p(i,j).area2 = p(i,j).area;
        for k=1:height(w(:,j))
            if w(k,j).point1 == p(i,j)
                p(i,j).area2 = p(i,j).area2 + w(k,j).t*w(k,j).length*1000/6*(2+(w(k,j).point2.y-ycd(j))/(p(i,j).y-ycd(j)));
            elseif w(j).point2 == p(i,j)
                p(i,j).area2 = p(i,j).area2 + w(k,j).t*w(k,j).length*1000/6*(2+(w(k,j).point1.y-ycd(j))/(p(i,j).y-ycd(j)));
            end
        end
        
    end
    
    %hitung Iy(j) = A*y^2 dalam m^4
    Iy(j) = 0;
    for i=1:height(p(:,j))
        Iy(j) = Iy(j) + p(i,j).area2*10^-6*(p(i,j).y-ycd(j))^2;
    end 
    Ix(j) = 0;
    for i=1:height(p(:,j))
        Ix(j) = Ix(j) + p(i,j).area2*10^-6*(p(i,j).x-xcd(j))^2;
    end 
    Ixy(j) = 0;
    for i=1:height(p(:,j))
        Ixy(j) = Ixy(j) + p(i,j).area2*10^-6*(p(i,j).x-xcd(j))*(p(i,j).y-ycd(j));
    end
    
    %hitung K
    Kyy(j) = Ix(j)/(Ix(j)*Iy(j)-Ixy(j)^2);
    Kxy(j) = Ixy(j)/(Ix(j)*Iy(j)-Ixy(j)^2);
    
    %output
    fprintf('Section %.3g\n',j)
    fprintf('Centroid di y = %.3g m\n',ycd(j))
    fprintf('Iy(j) = %.4g m^4\n',Iy(j))
    
    for i=1:length(p)
        % fprintf('Luas titik %s adalah %.2f mm^2\n',p(i,j).name,p(i,j).area2)
    end
end
