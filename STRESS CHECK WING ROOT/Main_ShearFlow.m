%buat matriks sistem pers Aq = b, untuk dapat q = A^-1*b

%vektor b
b = zeros(length(w),1);
%hitung dF/dx=V(Kyy*Qy-Kxy*Qx) Qy=A*y Qx=A*x
for i=1:length(p)-1
    b(i) = V*p(i).area2*10^-6*(Kyy*(p(i).y-ycd)-Kxy*(p(i).x-xcd));
end
%untuk bagian kompatibilitas twist
if length(w)-length(p)>0
    for i=length(p):length(w)-1
        b(i) = 0;
    end
end
%untuk bagian T (positif ccw dan pusat di x=0)
b(length(w)) = V*d + T;

%buat matrix A untuk membentuk sistem persamaan shear flow
A = zeros(length(w));
%hubungan q23 = VQ/I + q12
for i=1:length(p)-1
    for j=1:length(w)
        if w(j).point2 == p(i)
            for k = 1:length(p)
                A(i,j) = 1;
            end
        elseif w(j).point1 == p(i)
            for k = 1:length(p)
                A(i,j) = -1;
            end
        end
    end
end

%hubungan kompatibilitas twist sigma 1/A*L_i/t_i/G_i *q_i
if length(w)-length(p)>0
    for i=length(p):length(w)-1
        for j=1:length(w)
            for k=1:size([loop(i-length(p)+1).walls],2)
                if loop(i-length(p)+1).walls(k) == w(j)
                    A(i,j) = A(i,j) + loop(i-length(p)+1).dir(k)*w(j).length/w(j).t/w(j).material.G/loop(i-length(p)+1).area;
                    %fprintf('1) %d %s  ',i,w(j).name)
                    %fprintf('%.3g ',A(i,:))
                    %fprintf('\n')
                end
            end
            for k=1:size([loop(i-length(p)+2).walls],2)
                if loop(i-length(p)+2).walls(k) == w(j)
                    A(i,j) = A(i,j) - loop(i-length(p)+2).dir(k)*w(j).length/w(j).t/w(j).material.G/loop(i-length(p)+2).area;
                    %fprintf('2) %d %s  ',i,w(j).name)
                    %fprintf('%.1g ',A(i,:))
                    %fprintf('\n')
                end
            end
        end
    end
end
%hubungan dengan torsion T(q)=2qA
for i=1:length(w)
    dir = cross([w(i).point1.x w(i).point1.y 0],w(i).vector);
    if norm(dir)~=0
        dir = dir(3)/norm(dir);
    else
        dir = 0;
    end
    A(length(w),i) = 2*dir*polyarea([0 w(i).point1.x w(i).point2.x],...
        [0 w(i).point1.y w(i).point2.y]);
end
% A(8,9)=2;
% A(9,9)=-1;
% A(9,10)=2;
%output
q = inv(A)*b;
for i=1:length(w)
    w(i).q = q(i);
    w(i).tau = abs(w(i).q/w(i).t/1000);
    %fprintf('Wall %s shear flow %.0f N/m | shear stress %.2f MPa\n',w(i).name,w(i).q,w(i).tau)
end

