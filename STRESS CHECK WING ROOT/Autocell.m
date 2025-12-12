function [p,w] = Autocell(n,panjang,tinggi)
if n <= 0
    error('n harus satu atau lebih')
end

%generate point
p = Point('1',[0 0],0);
for i = 2:2+2*n
    name = i;
    p = [p Point(string(name),[0 0],0)];
end
%posisi sparcap atas
for i = 1:1+n
    p(i).x = -panjang/2 + panjang/n*(i-1);
    p(i).y = tinggi/2;
end
%posisi sparcap bawah
for i = 2+n:2+2*n
    p(i).x = panjang/2 - panjang/n*(i-2-n);
    p(i).y = -tinggi/2;
end

%generate wall mengelilingi
w = Wall('1_2',p(1),p(2),1);
for i = 2:2+2*n-1
    name = join([string(i) '_' string(i+1)],'');
    w = [w Wall(name,p(i),p(i+1),1)];
end
w = [w Wall(join([string(2+2*n) '_1'],''),p(2+2*n),p(1),1)];
%generate wall pemisah cell
%{
for i = 1:n-1
    point1 = 1+i; 
    point2 = size(p,2)-i;
    name = join([string(point1) '_' string(point2)],'');
    w = [w Wall(name,p(point1),p(point2),0)];
end
%}
%{
%define loop
for i=1:n
    if i==1
        loop(i) = Loop([p(1) p(2) p(size(p,2)-1) p(size(p,2))],[w(1) w(size(p,2)+1) w(size(p,2)-1) w(size(p,2))]);
    elseif i==n
        loop(i) = Loop([p(n) p(n+1) p(n+2) p(n+3)],[w(n) w(n+1) w(n+2) w(size(w,2))]);
    else
        loop(i) = Loop([p(1+i) p(2+i) p(size(p,2)-1-i) p(size(p,2)-i)],[w(1+i) w(size(p,2)+1+i) w(size(p,2)-1-i) w(size(p,2)+i)]);
    end
end
%}
p = p';
w = w';


end