%buat matriks sistem pers Aq = b, untuk dapat q = A^-1*b

%vektor b
b = zeros(size(w));
%hitung dF/dx=V(r)(Kyy*Qy-Kxy*Qx) Qy=A*y Qx=A*x
for r = 1:length(c_section)
    for i=1:height(p(:,r))-1
        b(i,r) = V_section(r)*p(i,r).area2*10^-6*(Kyy(r)*(p(i,r).y-ycd(r))-Kxy(r)*(p(i,r).x-xcd(r)));
    end
    %untuk bagian kompatibilitas twist
    if height(w(:,r))-height(p(:,r))>0
        for i=height(p(:,r)):height(w(:,r))-1
            b(i,r) = 0;
        end
    end
    %untuk bagian T(r) (positif ccw dan pusat di x=0)
    b(height(w(:,r)),r) = V_section(r)*d(r) + T_section(r);
    
    %buat matrix A untuk membentuk sistem persamaan shear flow
    A = zeros(height(w(:,r)));
    %hubungan q23 = V(r)Q/I + q12
    for i=1:height(p(:,r))-1
        for j=1:height(w(:,r))
            if w(j,r).point2 == p(i,r)
                for k = 1:height(p(:,r))
                    A(i,j) = 1;
                end
            elseif w(j,r).point1 == p(i,r)
                for k = 1:height(p(:,r))
                    A(i,j) = -1;
                end
            end
        end
    end
    
    %hubungan kompatibilitas twist sigma 1/A*L_i/t_i/G_i *q_i
    if height(w(:,r))-height(p(:,r))>0
        for i=height(p(:,r)):height(w(:,r))-1
            for j=1:height(w(:,r))
                for k=1:size([loop(i-height(p(:,r))+1).walls],2)
                    if loop(i-height(p(:,r))+1).walls(k) == w(j,r)
                        A(i,j) = A(i,j) + loop(i-height(p(:,r))+1).dir(k)*w(j,r).length/w(j,r).t/w(j,r).material.G/loop(i-height(p(:,r))+1).area;
                        %fprintf('1) %d %s  ',i,w(j).name)
                        %fprintf('%.3g ',A(i,:))
                        %fprintf('\n')
                    end
                end
                for k=1:size([loop(i-height(p(:,r))+2).walls],2)
                    if loop(i-height(p(:,r))+2).walls(k) == w(j)
                        A(i,j) = A(i,j) - loop(i-height(p(:,r))+2).dir(k)*w(j,r).length/w(j,r).t/w(j,r).material.G/loop(i-height(p(:,r))+2).area;
                        %fprintf('2) %d %s  ',i,w(j).name)
                        %fprintf('%.1g ',A(i,:))
                        %fprintf('\n')
                    end
                end
            end
        end
    end
    %hubungan dengan torsion T(r)(q)=2qA
    for i=1:height(w(:,r))
        dir = cross([w(i,r).point1.x w(i,r).point1.y 0],w(i,r).vector);
        if norm(dir)~=0
            dir = dir(3)/norm(dir);
        else
            dir = 0;
        end
        A(height(w(:,r)),i) = 2*dir*polyarea([0 w(i,r).point1.x w(i,r).point2.x],...
            [0 w(i,r).point1.y w(i,r).point2.y]);
    end
    % A(8,9)=2;
    % A(9,9)=-1;
    % A(9,10)=2;
    %output
    q = inv(A)*b;
    for i=1:height(w(:,r))
        w(i,r).q = q(i,r);
        w(i,r).tau = abs(w(i,r).q/w(i,r).t/1000);
        % fprintf('Wall %s shear flow %.0f N/m | shear stress %.2f MPa\n',w(i).name,w(i).q,w(i).tau)
    end
end
